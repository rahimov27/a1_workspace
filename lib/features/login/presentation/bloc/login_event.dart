part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginUserEvent({required this.userName, required this.password});
}
