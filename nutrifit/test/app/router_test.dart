import 'package:flutter_test/flutter_test.dart';
import 'package:nutrifit/app/router.dart';

void main() {
  group('sessionRedirect', () {
    test('signed out: public routes stay, private routes go to login', () {
      expect(
        sessionRedirect(userId: '', location: '/onboarding'),
        isNull,
      );
      expect(sessionRedirect(userId: '', location: '/login'), isNull);
      expect(sessionRedirect(userId: '', location: '/home'), '/login');
      expect(sessionRedirect(userId: '', location: '/scan'), '/login');
      expect(sessionRedirect(userId: '', location: '/recipes'), '/login');
    });

    test('signed in: public routes go to home, private routes stay', () {
      expect(sessionRedirect(userId: 'uid-1', location: '/onboarding'), '/home');
      expect(sessionRedirect(userId: 'uid-1', location: '/login'), '/home');
      expect(sessionRedirect(userId: 'uid-1', location: '/home'), isNull);
      expect(sessionRedirect(userId: 'uid-1', location: '/scan'), isNull);
      expect(sessionRedirect(userId: 'uid-1', location: '/profile'), isNull);
    });
  });
}
