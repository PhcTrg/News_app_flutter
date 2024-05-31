import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:news_reading/model/user_model.dart';

import 'package:news_reading/provider/home_provider.dart';

import 'fetch_login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('postLogin', () {
    test('NewsModel response successfully', () async {
      final client = MockClient();
      final homeProvider = HomeProvider();

      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({
        "username": 'ngphtruong050503@gmail.com',
        "password": "12345678",
      });

      // Use Mockito to set up a successful response
      when(client.post(
        Uri.parse('http://192.168.1.108:8000/api/login/'),
        headers: headers,
        body: body,
      )).thenAnswer((_) async => http.Response(
          '{ "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNzIzMDIyMSwiaWF0IjoxNzE3MTQzODIxLCJqdGkiOiI4ODkwNWJkYWMzZGU0MjIxYWQwNTBjODNhZTc3Y2I1YSIsInVzZXJfaWQiOjF9.sNrxG9Pxa1W-CYYf2dOAw5NYqp3CEM_Etqp8LwE3_1U", "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE3MTQ0MTIxLCJpYXQiOjE3MTcxNDM4MjEsImp0aSI6IjQzNjljYmIyNzg4ZjQzZTk4YTQ3MzVmNDM2NWNmMmYwIiwidXNlcl9pZCI6MX0.nDacx99zRp1clvHp_TqVxkBaK5PxxiF737EEBejfGTs" }',
          200));

      expect(
          await homeProvider.postLogin(
              "ngphtruong050503@gmail.com", "12345678"),
          isA<UserModel>());
    });

    test('Test result with error', () {
      final client = MockClient();
      final homeProvider = HomeProvider();

      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({
        "username": '1234567890',
        "password": "1234567890",
      });

      // Use Mockito to set up a failed response
      when(client.post(
        Uri.parse('http://192.168.1.108:8000/api/login/'),
        headers: headers,
        body: body,
      )).thenAnswer((_) async =>
          http.Response('{ "error": "Invalid username or password" }', 400));

      expect(homeProvider.postLogin("1234567890", "1234567890"),
          isA<Future<UserModel>>());
    });
  });
}
