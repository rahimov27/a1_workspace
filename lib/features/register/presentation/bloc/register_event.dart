part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String email;
  final String userName;
  final String password;

  RegisterUserEvent(
      {required this.email, required this.userName, required this.password});
}
