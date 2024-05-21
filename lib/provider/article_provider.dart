import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_reading/util/constant.dart';

String url = ConstValue().URL;

class ArticleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String createStatus = "";
  String articleContent = "";
  String contentLanguage = "en-US";

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
}
