part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterUserSuccess extends RegisterState {
  final String message;
  RegisterUserSuccess({required this.message});
}

class RegisterUserLoading extends RegisterState {}

class RegisterUserError extends RegisterState {
  final String error;
  RegisterUserError({required this.error});
}
