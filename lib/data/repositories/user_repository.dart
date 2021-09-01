import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journalio/data/models/user_model.dart';

class UserRepository {
  static void createUser(UserModel user, String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(user.toJson());
  }
}
