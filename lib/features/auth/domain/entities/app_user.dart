import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String? uid;
  final String? email;
  final bool emailVerified;

  const AppUser({
    this.uid,
    this.email,
    this.emailVerified = false
  });
  
  @override
  List<Object?> get props => [
    uid,
    email,
    emailVerified
  ];
}