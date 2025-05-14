import 'package:WardrobePlus/features/auth/domain/usecases/login_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/register_user.dart';
import 'package:WardrobePlus/features/auth/domain/usecases/reset_password.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? _userId;

  final LoginUser loginUser;
  final RegisterUser registerUser;
  final ResetPassword resetPassword;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.resetPassword,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<ResetEvent>(_onResetEvent);
    on<SetUserIdEvent>(_onSetUserIdEvent);
    on<ClearUserIdEvent>(_onClearUserIdEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await loginUser(event.email, event.password);
      emit(AuthSuccess(message: "Login successful!"));

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if(userId != null) {
        add(SetUserIdEvent(userId));
      }

    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await registerUser(event.name, event.email, event.password);
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

  void _onSetUserIdEvent(SetUserIdEvent event, Emitter<AuthState> emit) {
    _userId = event.userId;
    emit(UserIdSetState(event.userId));
  }

  void _onClearUserIdEvent(ClearUserIdEvent event, Emitter<AuthState> emitt) {
    _userId = null;
    emit(UserIdClearedState());
  }

  String? getCurrentUserId() {
    return _userId;
  }
}
