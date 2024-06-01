import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/Services/notifi_service.dart';
import 'package:news_reading/core/constant.dart';
import 'package:news_reading/model/news_model.dart';

String url = ConstValue().URL;

// ArticleProvider is a class that extends ChangeNotifier and DiagnosticableTreeMixin.
// It is used to manage the state of the articles in the app.
class ArticleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String createStatus = "";
  String articleContent = "";
  String contentLanguage = "en-US";

  String createCommentStatus = "";

  // This is a model for a new comment added.
  CommentsModel newAddedComment = CommentsModel(
      id: 0,
      content: "",
      createdAt: "",
      updatedAt: "",
      user_id: 0,
      username: "");

  // All these methods send HTTP requests to the server and handle the responses.
  // They also notify all the listeners of this provider when the state changes.

  // This method is used to add an article.
  Future<String> addArticle(String title, String content, String category,
      int userId, File? imgFile) async {
    // The method first converts the image file to base64.
    // Then it sends a POST request to the server with the article data.
    // If the response status code is 201, it means the article was created successfully.
    // The method then shows a notification and returns the createStatus.
    // If there's an error, it throws an exception.
    try {
      // Convert image file to base64
      List<int> imageBytes = imgFile!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse('http://$url:8000/api/articles/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "category": category,
          "user": userId,
          "image": base64Image,
        }),
      );

      if (response.statusCode == 201) {
        createStatus = "Create article successfully";

        // this is used to show notification to user
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

  // This method is used to update an article
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
        createStatus = "update article successfully";

        // this is used to show notification to user
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

  // This method is used to summarize an article
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

  // This method is used to add a comment
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

  // This method is used add followers.
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
        // this is used to show notification to user
        NotificationService().showNotification(
            title: 'You are now follower!!!',
            body: 'Check out your notification when new post added.');

        notifyListeners();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      createCommentStatus = "Create comment fail: $e";
      rethrow;
    }
  }
}
