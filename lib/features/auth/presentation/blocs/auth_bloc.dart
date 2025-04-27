import 'package:WardrobePlus/features/auth/domain/usecases/login_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/register_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/reset_password.dart';
import 'package:bloc/bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ResetPassword resetPassword;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.resetPassword
  }): super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<ResetEvent>(_onResetEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await loginUser(event.email, event.password);
      emit(AuthSuccess(message: "Login successful!"));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await registerUser(event.email, event.password);
      emit(AuthSuccess(message: "Registration successful!"));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onResetEvent(ResetEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await resetPassword(event.email);
      emit(AuthSuccess(message: "Reset successful!"));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}