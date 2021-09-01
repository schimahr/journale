import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginViewModel() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool _incorrectPassword = false;
  bool _userDoesNotExist = false;
  bool _invalidEmail = false;
  bool get incorrectPassword => _incorrectPassword;
  bool get userDoesNotExist => _userDoesNotExist;
  bool get invalidEmail => _invalidEmail;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void obscurePassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<bool> loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _signInSuccess();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _userDoesNotExistError();
      } else if (e.code == 'wrong-password') {
        _incorrectPasswordError();
      } else if (e.code == 'invalid-email') {
        _invalidEmailError();
      } else {
        print(e);
      }
      return false;
    }
  }

  void clearTextEditingControllers() {
    emailController.clear();
    passwordController.clear();
    _isObscure = true;
  }

  void loggingIn() {
    _isLoggingIn = true;
    notifyListeners();
  }

  void loggedIn() {
    _isLoggingIn = false;
    notifyListeners();
  }

  void _signInSuccess() {
    _invalidEmail = false;
    _userDoesNotExist = false;
    _incorrectPassword = false;
    clearTextEditingControllers();
    notifyListeners();
  }

  void _userDoesNotExistError() {
    _invalidEmail = false;
    _userDoesNotExist = true;
    _incorrectPassword = false;
    notifyListeners();
  }

  void _incorrectPasswordError() {
    _invalidEmail = false;
    _incorrectPassword = true;
    _userDoesNotExist = false;
    notifyListeners();
  }

  void _invalidEmailError() {
    _invalidEmail = true;
    _incorrectPassword = false;
    _userDoesNotExist = false;
    notifyListeners();
  }
}
