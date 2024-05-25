import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/core/constant.dart';
import 'package:news_reading/model/news_model.dart';

String url = ConstValue().URL;

class ArticleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String createStatus = "";
  String articleContent = "";
  String contentLanguage = "en-US";

  String createCommentStatus = "";

  // bool _isFollow = false;

  // set isFollow(bool value) {
  //   isFollow = value;
  // }

  // bool get isFollow => _isFollow;

  CommentsModel newAddedComment = CommentsModel(
      id: 0,
      content: "",
      createdAt: "",
      updatedAt: "",
      user: 0,
      article: 0,
      username: "");

  Future<String> addArticle(
      String title, String content, String category, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/articles/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "category": category,
          "user": userId
        }),
      );

      if (response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);
        createStatus = "Create article successfully";

        NotificationService().showNotification(
            title: 'Your article is now live',
            body: 'Your article: $title upload successfully');

        notifyListeners();

        return createStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createStatus = "Create article fail: $e";
      rethrow;
    }
  }

  Future<String> updateArticle(String title, String content, int userId,
      String category, int articleId) async {
    try {
      final response = await http.put(
        Uri.parse('http://$url:8000/api/articles/$articleId/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "category": category,
          "user": userId
        }),
      );

      if (response.statusCode == 200) {
        // final responseData = jsonDecode(response.body);
        createStatus = "update article successfully";

        NotificationService().showNotification(
            title: 'Your article is update successfully',
            body: 'Your article: $title update successfully');

        notifyListeners();

        return createStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createStatus = "update article fail: $e";
      rethrow;
    }
  }

  Future<String> summarizeArticle(String content) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/summary/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "text": content,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        notifyListeners();

        return responseData['summary'];
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createStatus = "Summarize fail: $e";
      rethrow;
    }
  }

  Future<CommentsModel> addComment(
      String content, int userId, int articleId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/comments/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "content": content,
          "user": userId,
          "article": articleId,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        newAddedComment = CommentsModel.fromJson(responseData);
        createCommentStatus = "Create comment successfully";

        notifyListeners();

        return newAddedComment;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createCommentStatus = "Create comment fail: $e";
      rethrow;
    }
  }

  Future<bool> addFollowers(int userId, int followerId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/followers/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "user": userId,
          "follower": followerId,
        }),
      );

      if (response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);

        NotificationService().showNotification(
            title: 'You are now follower!!!',
            body: 'Check out your notification when new post added.');

        notifyListeners();

        return true;
      } else {
        // throw Exception(response.body);

        return false;
      }
    } catch (e) {
      // createCommentStatus = "Create comment fail: $e";
      rethrow;
    }
  }
}
