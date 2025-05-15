import 'package:WardrobePlus/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:WardrobePlus/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final SupabaseAuthDatasource supabaseAuthDatasource;

  AuthRepositoryImpl(this.supabaseAuthDatasource);

  @override
  Future<void> loginUser(String email, String password) async {
    return await supabaseAuthDatasource.loginUser(email, password);
  }

  @override
  Future<void> registerUser(String name, String email, String password) async {
    return await supabaseAuthDatasource.registerUser(name, email, password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await supabaseAuthDatasource.resetPassword(email);
  }
}