import 'package:flutter/material.dart';
import 'package:news_reading/model/followers.dart';
import 'package:news_reading/model/news_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/core/constant.dart';
import 'package:http/http.dart' as http;

String url = ConstValue().URL;

// ProfileProvider is a class that extends ChangeNotifier. It is used to manage the state of the profile in the app.
class ProfileProvider extends ChangeNotifier {
  // This is a list of news models.
  List<NewsModel> _news = [];
  // This is a getter for the news list.
  List<NewsModel> get news => _news;

  @override
  void dispose() {
    super.dispose();
  }

  // This method is used to get news data for a specific user. It sends a GET request to the server and updates the news list with the response data. It then notifies any listeners.
  Future<List<NewsModel>> getNewsData(int userID) async {
    print(userID);
    final response = await http
        .get(Uri.parse('http://$url:8000/api/articles/?page=1&userID=$userID'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData['results'];

      _news = jsonData.map((data) => NewsModel.fromJson(data)).toList();

      notifyListeners();

      return _news;
    } else {
      throw Exception('Failed to load');
    }
  }

  // This method is used to get the number of users that the current user is following. It sends a GET request to the server and returns the number of users that the current user is following.
  Future<String> getFollowing(int userID) async {
    final response = await http
        .get(Uri.parse('http://$url:8000/api/following/?user_id=$userID'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      var userList = jsonData.map((data) => UserModel.fromJson(data)).toList();

      notifyListeners();

      return userList.length.toString();
    } else {
      throw Exception('Failed to load');
    }
  }

  // This method is used to get the number of followers of the current user. It sends a GET request to the server and returns the number of followers of the current user.
  Future<String> getFollower(int userID) async {
    final response = await http
        .get(Uri.parse('http://$url:8000/api/followers/?user_id=$userID'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      var userList =
          jsonData.map((data) => FollowersModel.fromJson(data)).toList();

      notifyListeners();

      return userList.length.toString();
    } else {
      throw Exception('Failed to load');
    }
  }

  // This method is used to check if the current user is following another user or not. It sends a GET request to the server and returns a boolean value indicating whether the current user is following the other user or not.
  Future<bool> isFollowingOrNot(int dangNhapId, int isFollowingId) async {
    final response = await http
        .get(Uri.parse('http://$url:8000/api/following/?user_id=$dangNhapId'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      var userList = jsonData.map((data) => UserModel.fromJson(data)).toList();

      for (UserModel user in userList) {
        if (user.id == isFollowingId) {
          return true;
        }
      }

      return false;
    } else {
      throw Exception('Failed to load');
    }
  }
}
