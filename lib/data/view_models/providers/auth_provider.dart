import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<User?> get currentUser async {
    return _auth.currentUser;
  }

  String get userEmail {
    String? _tempEmail = _auth.currentUser?.email;
    String _userEmail = '';
    var _tempVar = _tempEmail;
    if (_tempVar != null) {
      _userEmail = _tempVar;
    }
    return _userEmail;
  }

  String get userDisplayName {
    String? _tempDisplayName = _auth.currentUser?.displayName;
    String _userDisplayName = '';
    var _tempVar = _tempDisplayName;
    if (_tempVar != null) {
      _userDisplayName = _tempVar;
    }
    return _userDisplayName;
  }

  Stream<User?> userStream() {
    return _auth.authStateChanges();
  }

  String get getCurrentUserID {
    String? _tempCurrentUserID = FirebaseAuth.instance.currentUser?.uid;
    String _currentUserID = '';
    var _tempVar = _tempCurrentUserID;
    if (_tempVar != null) {
      _currentUserID = _tempVar;
    }
    return _currentUserID;
  }
}
