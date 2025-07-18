import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
import '../domain/entities/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _service;

  AuthViewModel(this._service) {
    _service.userStream.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? _user;
  User? get user => _user;

  Future<void> signIn(String email, String password) async {
    await _service.signIn(email, password);
  }

  Future<void> register(String email, String password) async {
    await _service.register(email, password);
  }

  Future<void> signOut() async {
    await _service.signOut();
  }
}
