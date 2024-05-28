import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:news_reading/model/news_model.dart';

import 'package:http/http.dart' as http;
import 'package:news_reading/model/notification_model.dart';
import 'package:news_reading/model/user_model.dart';
import 'package:news_reading/core/constant.dart';
import 'package:news_reading/core/token_decode.dart';

String url = ConstValue().URL;

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _page = 1;
  bool _isLogin = false;
  String _validateCode = "";
  String _loginStatus = '';
  String _signUpStatus = '';
  String _updateStatus = '';
  String _forgotpassStatus = '';
  UserModel _userModel =
      UserModel(id: 0, firstName: "", lastName: "", role: "");
  List<NotificationModel> _notification = [];
  List<NewsModel> _news = [];
  Future<UserModel>? _futureUser;
  Future<String>? codeFuture;

  set futureUser(Future<UserModel>? value) {
    _futureUser = value;
  }

  set news(List<NewsModel> value) {
    _news = value;
  }

  set signUpStatus(String value) {
    _signUpStatus = value;
  }

  set updateStatus(String value) {
    _updateStatus = value;
  }

  set validateCode(String value) {
    _validateCode = value;
  }

  set forgotpassStatus(String value) {
    _forgotpassStatus = value;
  }

  bool get isLogin => _isLogin;
  String get loginStatus => _loginStatus;
  String get signUpStatus => _signUpStatus;
  String get updateStatus => _updateStatus;
  String get validateCode => _validateCode;
  String get forgotpassStatus => _forgotpassStatus;
  UserModel get userModel => _userModel;
  List<NewsModel> get news => _news;
  List<NotificationModel> get notification => _notification;
  Future<UserModel>? get futureUser => _futureUser;

  void userLogout() {
    _isLogin = false;
    _userModel = UserModel(id: 0, firstName: "", lastName: "", role: "");

    notifyListeners();
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

  Future<List<NewsModel>> getNewsData() async {
    final response =
        await http.get(Uri.parse('http://$url:8000/api/articles/?page=$_page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      List<dynamic> jsonData = responseData['results'];

      List<NewsModel> newItem =
          jsonData.map((data) => NewsModel.fromJson(data)).toList();

      _news.addAll(newItem);

      if (_news.length < responseData['count']) {
        _page++;
      }

      notifyListeners();

      return newItem;
    } else {
      // throw Exception('Failed to load');
      return _news;
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

    print(userName + " " + password);

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
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
      print(response.statusCode);
      _loginStatus = "Invalid user name or password";

      return UserModel(id: 0, firstName: "", lastName: "", role: "");
    }
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

  Future<String> updateUser(
      String firstname, String lastname, String role, int userId) async {
    final response = await http.put(
      Uri.parse('http://$url:8000/api/users/$userId/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        "first_name": firstname,
        "last_name": lastname,
        "role": role,
      }),
    );

    if (response.statusCode == 200) {
      _updateStatus = "Update user successfully";
      notifyListeners();

      return _updateStatus;
    } else {
      _updateStatus = "Upate fail";
      return _updateStatus;
    }
  }

  Future<String> getCodeForgot(String username) async {
    final response = await http.post(
      Uri.parse('http://$url:8000/api/forgot-password/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        "username": username,
      }),
    );

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      _validateCode = responseData['reset_code'];
      _forgotpassStatus = "Your code is send";
      notifyListeners();

      return _forgotpassStatus;
    } else {
      _forgotpassStatus =
          "Fail to send code, please make your you type exist email";
      return _forgotpassStatus;
    }
  }

  Future<String> resetPassword(
      String username, String reset_code, String new_password) async {
    print(username + " " + reset_code + " " + new_password);
    final response = await http.post(
      Uri.parse('http://$url:8000/api/reset-password/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, dynamic>{
        "username": username,
        "reset_code": reset_code,
        "new_password": new_password
      }),
    );

    // final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // _validateCode = responseData['reset_code'];
      _forgotpassStatus = "Password reset successfully";
      notifyListeners();

      return _forgotpassStatus;
    } else {
      _forgotpassStatus = "Code is invalid or expired";
      return _forgotpassStatus;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
