import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await authRepository.loginUser(event.email, event.password);
        if (response.statusCode == 200) {
          emit(AuthSuccess(response.data["token"]));
        } else {
          emit(AuthFailure("Login failed"));
        }
      } catch (e) {
        emit(AuthFailure("Error: $e"));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await authRepository.registerUser(event.username, event.email, event.password, event.imagePath);
        if (response.statusCode == 201) {
          emit(AuthSuccess(response.data["token"]));
        } else {
          emit(AuthFailure("Registration failed"));
        }
      } catch (e) {
        emit(AuthFailure("Error: $e"));
      }
    });

    on<LogoutRequested>((event, emit) async {
        try {
          await authRepository.logout();  // Implement this in AuthRepository
          emit(AuthUnauthenticated());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
    });

  }
}
