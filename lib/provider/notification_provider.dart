import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_reading/model/notification_model.dart';
import 'package:news_reading/util/constant.dart';
import 'package:http/http.dart' as http;

String url = ConstValue().URL;

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notification = [];
  List<NotificationModel> get news => _notification;

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<NotificationModel>> getNotifications(int userID) async {
    final response = await http.get(
        Uri.parse('http://$url:8000/api/user_notifications/?user_id=5$userID'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      _notification =
          jsonData.map((data) => NotificationModel.fromJson(data)).toList();

      notifyListeners();

      return _notification;
    } else {
      throw Exception('Failed to load');
    }
  }
}
