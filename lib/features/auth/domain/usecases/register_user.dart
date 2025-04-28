import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<void> call(String name, String email, String password) async {
    return await repository.registerUser(name, email, password);
  }
}