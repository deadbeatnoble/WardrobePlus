import 'package:WardrobePlus/features/auth/data/datasources/firebase_auth_datasource.dart';
import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final FirebaseAuthDatasource firebaseAuthDatasource;

  AuthRepositoryImpl(this.firebaseAuthDatasource);

  @override
  Future<void> loginUser(String email, String password) async {
    return await firebaseAuthDatasource.loginUser(email, password);
  }

  @override
  Future<void> registerUser(String name, String email, String password) async {
    return await firebaseAuthDatasource.registerUser(name, email, password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await firebaseAuthDatasource.resetPassword(email);
  }
}