import 'package:app/firebase/auth.dart';
import 'package:app/models/firebase_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key, required this.name, required this.summary});

  final String name;
  final String summary;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String get name => widget.name;
  String get summary => widget.summary;
  late Future<FirebaseUser?> userFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 400,
          child: Row(children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Container(
                color: const Color.fromARGB(
                    255, 0, 0, 0), // Placeholder for an image or avatar
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(name),
                const SizedBox(height: 16),
                Text(summary),
              ],
            ),
            const Spacer(),
          ]),
        ),
      ),
    );
  }
}
