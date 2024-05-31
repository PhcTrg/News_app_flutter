import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:news_reading/model/news_model.dart';
import 'package:mockito/annotations.dart';

import 'package:news_reading/provider/home_provider.dart';

import 'fetch_login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getNewsData', () {
    // test('NewsModel response successfully', () async {
    //   final client = MockClient();
    //   final homeProvider = HomeProvider();

    //   // Use Mockito to set up a successful response
    //   when(client
    //           .get(Uri.parse('http://192.168.1.108:8000/api/articles/?page=1')))
    //       .thenAnswer((_) async => http.Response(
    //           '{"results": [], "next": "http://192.168.1.108:8000/api/articles/?page=2", "previous": null, "count": 36}',
    //           200));

    //   expect(await homeProvider.getNewsData(client), isA<List<NewsModel>>());
    // });

    test('Test result with error', () {
      final client = MockClient();
      final homeProvider = HomeProvider();

      // Use Mockito to set up a failed response
      when(client.get(
              Uri.parse('http://192.168.1.108:8000/api/articles/?page=aewfw')))
          .thenAnswer(
              (_) async => http.Response('{ "detail": "Invalid page." }', 404));

      expect(homeProvider.getNewsData(client), isA<Future<List<NewsModel>>>());
    });
  });
}
