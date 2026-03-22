import 'package:equatable/equatable.dart';
import 'package:taskmanager/features/auth/domain/entities/app_user.dart';
import 'package:taskmanager/features/auth/domain/entities/app_error.dart';

class AppAuthCredential extends Equatable {
  final AppUser? user;
  final AppError? error;

  const AppAuthCredential({this.user, this.error});
  
  @override
  List<Object?> get props => [
    user,
    error
  ];
}