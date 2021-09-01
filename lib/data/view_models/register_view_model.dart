import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journalio/data/models/user_model.dart';
import 'package:journalio/data/repositories/user_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  late TextEditingController displayNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void obscurePassword() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  RegisterViewModel() {
    displayNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool _isRegistering = false;
  bool get isRegistering => _isRegistering;

  bool _weakPassword = false;
  bool _emailAlreadyUsed = false;
  bool _invalidEmail = false;

  bool get weakPassword => _weakPassword;
  bool get emailAlreadyUsed => _emailAlreadyUsed;
  bool get invalidEmail => _invalidEmail;

  void _registerSuccess() {
    _invalidEmail = false;
    _emailAlreadyUsed = false;
    _weakPassword = false;
    clearTextEditingControllers();
    notifyListeners();
  }

  void _weakPasswordError() {
    _invalidEmail = false;
    _emailAlreadyUsed = false;
    _weakPassword = true;
    notifyListeners();
  }

  void _emailAlreadyUsedError() {
    _invalidEmail = false;
    _emailAlreadyUsed = true;
    _weakPassword = false;
    notifyListeners();
  }

  void _invalidEmailError() {
    _invalidEmail = true;
    _emailAlreadyUsed = false;
    _weakPassword = false;
    notifyListeners();
  }

  void registering() {
    _isRegistering = true;
    notifyListeners();
  }

  void registered() {
    _isRegistering = false;
    notifyListeners();
  }

  Future<bool> registerUser() async {
    try {
      UserCredential newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      User? user = newUser.user;
      user!.updateDisplayName(displayNameController.text);

      UserModel userModel = UserModel(
          id: newUser.user!.uid,
          displayName: displayNameController.text,
          email: emailController.text);
      UserRepository.createUser(userModel, newUser.user!.uid);
      _registerSuccess();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _weakPasswordError();
      } else if (e.code == 'email-already-in-use') {
        _emailAlreadyUsedError();
      } else if (e.code == 'invalid-email') {
        _invalidEmailError();
      } else {
        print(e);
      }
      return false;
    }
  }

  void clearTextEditingControllers() {
    displayNameController.clear();
    emailController.clear();
    passwordController.clear();
    _isObscure = true;
  }
}
