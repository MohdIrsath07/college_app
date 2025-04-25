import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:college_app/models/user_model.dart';
import 'package:college_app/services/firebase_auth_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuth => _user != null;

  Future<bool> tryAutoLogin() async {
    final currentUser = _authService.currentUser;
    if (currentUser == null) {
      return false;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final userData = await _authService.getUserData(currentUser.uid);
      if (userData != null) {
        _user = userData;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential =
      await _authService.signInWithEmailAndPassword(email, password);
      final userData = await _authService.getUserData(userCredential.user!.uid);

      if (userData != null) {
        _user = userData;
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      _error = 'User data not found';
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password,
      String department, DateTime dateOfBirth) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential =
      await _authService.registerWithEmailAndPassword(email, password);

      // Generate a student ID (you may use a more complex logic)
      final studentId = 'ST${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      final newUser = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        department: department,
        dateOfBirth: dateOfBirth,
        studentId: studentId,
      );

      await _authService.createUserInFirestore(newUser);

      _user = newUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.resetPassword(email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;RW
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile(UserModel updatedUser) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.updateUserData(updatedUser);

      _user = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}