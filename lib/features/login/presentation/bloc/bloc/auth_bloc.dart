import 'package:a1_workspace/features/login/services/firebase_auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService repo;

  AuthBloc({required this.repo}) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state
    try {
      final user = await repo.login(email: event.login, password: event.password);
      emit(AuthSuccess(user: user)); // Emit success state with user data
    } catch (e) {
      emit(AuthError(error: e.toString())); // Emit error state
    }
  }
}
