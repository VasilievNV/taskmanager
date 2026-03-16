import 'package:taskmanager/domain/entity/app_user.dart';
import 'package:taskmanager/domain/entity/error.dart';

class AppAuthCredential {
  final AppUser? user;
  final AppError? error;

  AppAuthCredential({this.user, this.error});
}