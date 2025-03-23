part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

final class EditInitial extends EditState {}

class EditUserLoading extends EditState {}

class EditUserSuccess extends EditState {
  final String message;
  EditUserSuccess({required this.message});
}

class EditUserError extends EditState {
  final String error;
  EditUserError({required this.error});
}
