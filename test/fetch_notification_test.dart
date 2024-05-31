import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:news_reading/model/notification_model.dart';

import 'package:news_reading/provider/notification_provider.dart';

import 'fetch_login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getNotifications', () {
    test('Notification response successfully', () async {
      final client = MockClient();
      final homeProvider = NotificationProvider();

      // Use Mockito to set up a successful response
      when(client.get(Uri.parse(
              'http://192.168.1.108:8000/api/user_notifications/?user_id=1')))
          .thenAnswer((_) async => http.Response(
              '[ { "message": "New article "test" published by trant.nhan2003@gmail.com", "follower": { "id": 1, "username": "ngphtruong050503@gmail.com", "first_name": "Truong", "last_name": "nguyen" }, "article": { "id": 41, "title": "test", "content": "test", "user": 2, "created_at": "2024-05-29T02:32:22.097000Z", "updated_at": "2024-05-29T02:32:22.097000Z" }, "timestamp": "2024-05-29T02:32:22.823000Z" } ]',
              200));

      expect(await homeProvider.getNotifications(1),
          isA<List<NotificationModel>>());
    });

    test('Test result with error', () {
      final client = MockClient();
      final homeProvider = NotificationProvider();

      // Use Mockito to set up a failed response
      when(client.get(Uri.parse(
              'http://192.168.1.108:8000/api/user_notifications/?user_id=999')))
          .thenAnswer(
              (_) async => http.Response('{ "error": "User not found" }', 404));

      expect(homeProvider.getNotifications(999),
          isA<Future<List<NotificationModel>>>());
    });
  });
}
