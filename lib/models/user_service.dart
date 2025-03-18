import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakers_app/models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception("Database error: $e");
    }
  }
}
