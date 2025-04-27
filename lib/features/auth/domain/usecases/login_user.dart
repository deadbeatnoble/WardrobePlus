import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<void> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }
}