import 'package:flutter_test/flutter_test.dart';
import 'package:taskmanager/features/auth/data/models/user_model.dart';
import 'package:taskmanager/features/auth/domain/entities/app_user.dart';

void main() {
  const tUid = '123';
  const tEmail = 'test@example.com';
  const tEmailVerified = true;

  const tUserModel = UserModel(
    uid: tUid,
    email: tEmail,
    emailVerified: tEmailVerified,
  );

  const tJson = {
    'uid': tUid,
    'email': tEmail,
    'email_verified': tEmailVerified,
  };

  group('UserModel', () {
    test('should be a subclass of AppUser entity', () {
      expect(tUserModel, isA<AppUser>());
    });

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        final result = UserModel.fromJson(tJson);
        expect(result, tUserModel);
      });

      test('should handle null/missing values with defaults', () {
        final result = UserModel.fromJson({});
        expect(result.uid, null);
        expect(result.email, null);
        expect(result.emailVerified, null);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        final result = tUserModel.toJson();
        final expectedMap = {
          'uid': tUid,
          'email': tEmail,
          'email_verified': tEmailVerified,
        };
        expect(result, expectedMap);
      });
    });
  });
}