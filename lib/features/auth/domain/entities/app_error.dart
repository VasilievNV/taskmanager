import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final int? code;
  final String? message;

  const AppError({
    this.code,
    this.message
  });
  
  @override
  List<Object?> get props => [
    code,
    message
  ];
}