import 'package:app/firebase/auth.dart';
import 'package:app/models/firebase_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key, required this.uid});

  final String uid;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String get uid => widget.uid;
  late Future<FirebaseUser?> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = Auth().getUserDetailsById(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: LayoutBuilder(builder: (context, constraints) {
      return Card(
        child: FutureBuilder<FirebaseUser?>(
            future: userFuture,
            builder: (contex, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final user = snapshot.data;
                return Column(
                  children: [
                    Text(user?.firstName ?? 'No First Name'),
                    Text(user?.email ?? 'No Email'),
                  ],
                );
              } else {
                return Text('No user data available');
              }
            }),
      );
    }));
  }
}
