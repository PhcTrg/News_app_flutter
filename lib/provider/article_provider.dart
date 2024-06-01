import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/core/constant.dart';
import 'package:news_reading/model/news_model.dart';

String url = ConstValue().URL;

class ArticleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String articleContent = "";
  String contentLanguage = "en-US";

  String createCommentStatus = "";

  CommentsModel newAddedComment = CommentsModel(
      id: 0,
      content: "",
      createdAt: "",
      updatedAt: "",
      user_id: 0,
      // article: 0,
      username: "");

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
      // createStatus = "Summarize fail: $e";
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
        Uri.parse('http://$url:8000/api/follower/'),
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
