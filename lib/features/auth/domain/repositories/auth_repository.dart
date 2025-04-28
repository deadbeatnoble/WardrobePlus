abstract class AuthRepository {
  Future<void> registerUser(String name, String email, String password);
  Future<void> loginUser(String email, String password);
  Future<void> resetPassword(String email);
}