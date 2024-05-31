import 'package:flutter_test/flutter_test.dart';
import 'package:news_reading/provider/home_provider.dart';

void main() {
  group('User Logout', () {
    final homeProvider = HomeProvider();

    test('Logout should reset user data', () {
      homeProvider.userLogout();

      expect(homeProvider.isLogin, false);
      expect(homeProvider.userModel.id, 0);
      expect(homeProvider.userModel.firstName, '');
      expect(homeProvider.userModel.lastName, '');
      expect(homeProvider.userModel.role, '');
    });
  });
}
