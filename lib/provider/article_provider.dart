import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/util/constant.dart';

String url = ConstValue().URL;

class ArticleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String createStatus = "";
  String articleContent = "";
  String contentLanguage = "en-US";

  String createCommentStatus = "";

  Future<String> addArticle(String title, String content, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/articles/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "user": userId
        }),
      );

      if (response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);
        createStatus = "Create article successfully";

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

  Future<String> updateArticle(
      String title, String content, int userId, int articleId) async {
    try {
      final response = await http.put(
        Uri.parse('http://$url:8000/api/articles/$articleId/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
          "content": content,
          "user": userId
        }),
      );

      if (response.statusCode == 200) {
        // final responseData = jsonDecode(response.body);
        createStatus = "update article successfully";

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

  Future<String> addComment(String content, int userId, int articleId) async {
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
        // final responseData = jsonDecode(response.body);
        createCommentStatus = "Create comment successfully";

        notifyListeners();

        return createCommentStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      createCommentStatus = "Create comment fail: $e";
      rethrow;
    }
  }
}
