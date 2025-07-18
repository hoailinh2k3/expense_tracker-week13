import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<User?> register(String email, String password) =>
      remote.register(email, password);

  @override
  Future<User?> signIn(String email, String password) =>
      remote.signIn(email, password);

  @override
  Future<void> signOut() => remote.signOut();

  @override
  Stream<User?> authStateChanges() => remote.userStream;
}
