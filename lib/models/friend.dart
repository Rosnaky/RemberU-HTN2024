import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  final String uid;
  final String photoUrl;
  final String summary;
  final DateTime lastSeen;

  const Friend({
    required this.uid,
    required this.photoUrl,
    required this.summary,
    required this.lastSeen,
  });
}
