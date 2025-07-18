import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../../domain/entities/user.dart';

class AuthRemoteDataSource {
  final fb.FirebaseAuth _auth;

  AuthRemoteDataSource(this._auth);

  Stream<User?> get userStream => _auth.authStateChanges().map((fb.User? user) =>
      user == null ? null : User(id: user.uid, email: user.email ?? ''));

  Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    final user = cred.user;
    if (user == null) return null;
    return User(id: user.uid, email: user.email ?? '');
  }

  Future<User?> register(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final user = cred.user;
    if (user == null) return null;
    return User(id: user.uid, email: user.email ?? '');
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
