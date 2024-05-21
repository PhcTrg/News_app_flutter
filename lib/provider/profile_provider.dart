import 'package:flutter/material.dart';
import 'package:news_reading/model/news_model.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_reading/util/constant.dart';
import 'package:http/http.dart' as http;

String url = ConstValue().URL;

class ProfileProvider extends ChangeNotifier {
  List<NewsModel> _news = [];
  List<NewsModel> get news => _news;

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<NewsModel>> getNewsData(int userID) async {
    final response = await http
        .get(Uri.parse('http://$url:8000/api/articles/?userID=$userID'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      _news = jsonData.map((data) => NewsModel.fromJson(data)).toList();

      notifyListeners();

      return _news;
    } else {
      throw Exception('Failed to load');
    }
  }
}
