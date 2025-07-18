import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository repository;

  AuthService(this.repository);

  Stream<User?> get userStream => repository.authStateChanges();

  Future<User?> signIn(String email, String password) =>
      repository.signIn(email, password);

  Future<User?> register(String email, String password) =>
      repository.register(email, password);

  Future<void> signOut() => repository.signOut();
}
