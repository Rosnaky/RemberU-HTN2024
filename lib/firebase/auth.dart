import 'package:app/models/firebase_user.dart' as userModel;
import 'package:app/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "No user found for that email";
      } else if (e.code == "wrong-password") {
        res = "Wrong password provided for that user";
      } else if (e.code == "invalid-email") {
        res = "The email address is badly formatted";
      }
    } on Exception catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String displayName,
    required List<Friend> friends,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          displayName.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        userModel.FirebaseUser user = userModel.FirebaseUser(
            firstName: firstName,
            lastName: lastName,
            email: email,
            displayName: displayName,
            uid: userCredential.user!.uid,
            friends: friends);

        await _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = "Success";
      } else {
        res = "Please fill all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        res = "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        res = "The account already exists for that email";
      } else if (e.code == "invalid-email") {
        res = "The email address is badly formatted";
      }
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<userModel.FirebaseUser?> getUserDetails() async {
    User user = _auth.currentUser!;

    try {
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(user.uid).get();
      return userModel.FirebaseUser.fromSnap(snap);
    } on Exception {
      Auth().logout();
    }
    return null;
  }

  Future<userModel.FirebaseUser?> getUserDetailsById(String uid) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(uid).get();
      return userModel.FirebaseUser.fromSnap(snap);
    } on Exception {
      Auth().logout();
    }
    return null;
  }
}
