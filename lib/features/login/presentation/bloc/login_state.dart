part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginUserLoading extends LoginState {}

class LoginUserSuccess extends LoginState {
  final String message;
  LoginUserSuccess({required this.message});
}

class LoginUserError extends LoginState {
  final String error;
  LoginUserError({required this.error});
}
