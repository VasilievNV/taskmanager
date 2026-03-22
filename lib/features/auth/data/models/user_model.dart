import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/features/auth/domain/entities/app_user.dart';

class UserModel extends AppUser {
  const UserModel({
    super.uid,
    super.email,
    super.emailVerified,
  });

  factory UserModel.fromFirebase(User? user) {
    return UserModel(
      uid: user?.uid,
      email: user?.email,
      emailVerified: user?.emailVerified
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      emailVerified: json['email_verified'] as bool?, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'email_verified': emailVerified,
    };
  }
}