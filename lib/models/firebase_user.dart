import 'package:app/models/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  final String uid;
  final String email;
  final String displayName;
  final String firstName;
  final String lastName;
  final List<Friend> friends;

  const FirebaseUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.friends,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "displayName": displayName,
        "uid": uid,
        "friends": [],
      };

  static FirebaseUser fromSnap(DocumentSnapshot snap) {
    return FirebaseUser(
      firstName: snap.get("firstName"),
      lastName: snap.get("lastName"),
      email: snap.get("email"),
      displayName: snap.get("displayName"),
      uid: snap.get("uid"),
      // This part parses friends from Firestore
      friends: (snap.get("friends") as List<dynamic>).map((friendData) {
        return Friend(
          name: friendData['name'],
          photoUrl: friendData['photoUrl'],
          summary: friendData['summary'],
          lastSeen: DateTime.parse(friendData['lastSeen']),
          location: friendData['location'],
        );
      }).toList(),
    );
  }
}
