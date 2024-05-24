import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_reading/model/news_model.dart';

import 'package:http/http.dart' as http;
import 'package:news_reading/model/notification_model.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/util/constant.dart';
import 'package:news_reading/util/token_decode.dart';

String url = ConstValue().URL;

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Future<UserModel>? _futureUser;
  Future<UserModel>? get futureUser => _futureUser;
  set futureUser(Future<UserModel>? value) {
    _futureUser = value;
  }

  List<NewsModel> _news = [];
  List<NewsModel> get news => _news;
  set news(List<NewsModel> value) {
    _news = value;
  }

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  String _loginStatus = '';
  String get loginStatus => _loginStatus;

  String _signUpStatus = '';
  String get signUpStatus => _signUpStatus;
  set signUpStatus(String value) {
    _signUpStatus = value;
  }

  UserModel _userModel =
      UserModel(id: 0, firstName: "", lastName: "", role: "");
  UserModel get userModel => _userModel;

  List<NotificationModel> _notification = [];
  List<NotificationModel> get notification => _notification;

  Future<List<NewsModel>> getNewsData() async {
    final response =
        await http.get(Uri.parse('http://$url:8000/api/articles/'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // List<dynamic> jsonData = responseData['results'];
      List<dynamic> jsonData = responseData;

      var news = jsonData.map((data) => NewsModel.fromJson(data)).toList();

      notifyListeners();

      return news;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<String> postSignUp(String userName, String password, String firstname,
      String lastname, String role) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/users/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "username": userName,
          "password": password,
          "first_name": firstname,
          "last_name": lastname,
          "role": role,
        }),
      );

      if (response.statusCode == 201) {
        // final responseData = json.decode(response.body);
        _signUpStatus = "Sign up successfully";

        notifyListeners();

        return _signUpStatus;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      _loginStatus = "Sign up fail: $e";
      rethrow;
    }
  }

  Future<UserModel> postLogin(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://$url:8000/api/login/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, dynamic>{
          "username": userName,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _isLogin = true;
        _loginStatus = "Login Successful";

        // save token to localstorage
        // final storage = FlutterSecureStorage();
        // await storage.write(key: 'access_token', value: responseData['access']);
        // final accessToken = await storage.read(key: 'access_token');

        // decode token
        final userId =
            TokenDecode().parseJwtPayLoad(responseData['access'])['user_id'];

        // retrive user data
        _userModel = await postUserInfo(userId);

        notifyListeners();

        print(userModel.id);

        return _userModel;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      _loginStatus = "Login fail: $e";
      rethrow;
    }
  }

  void userLogout() {
    _isLogin = false;
    _userModel = UserModel(id: 0, firstName: "", lastName: "", role: "");

    notifyListeners();
  }

  Future<UserModel> postUserInfo(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://$url:8000/api/users/$id'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        _userModel = UserModel(
            id: responseData['id'],
            firstName: responseData['first_name'],
            lastName: responseData['last_name'],
            role: responseData['role']);

        notifyListeners();

        return _userModel;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      _loginStatus = "Login fail: $e";
      rethrow;
    }
  }

  Future<List<NotificationModel>> getNotifications(int userID) async {
    final response = await http.get(
        Uri.parse('http://$url:8000/api/user_notifications/?user_id=$userID'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData;

      var _notification =
          jsonData.map((data) => NotificationModel.fromJson(data)).toList();

      notifyListeners();

      return _notification;
    } else {
      throw Exception('Failed to load');
    }
  }

  void updateLogin(bool v) {
    _isLogin = v;
    notifyListeners();
  }

  void searchArticle({required String input}) async {
    final searchResult = news.where((element) {
      final newTitle = element.title.toLowerCase();
      final inputLow = input.toLowerCase();

      return newTitle.contains(inputLow);
    }).toList();

    news = searchResult;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty('news', news));
  //   // properties.add(BoolProperty('isLogin', isLogin));
  // }
}
