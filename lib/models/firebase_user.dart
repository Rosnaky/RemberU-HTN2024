import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String uid;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;

  const FirebaseUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "displayName": displayName,
        "uid": uid,
      };

  static FirebaseUser fromSnap(DocumentSnapshot snap) {
    return FirebaseUser(
      firstName: snap.get("firstName"),
      lastName: snap.get("lastName"),
      email: snap.get("email"),
      displayName: snap.get("displayName"),
      uid: snap.get("uid"),
    );
  }
}
