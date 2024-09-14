import 'package:app/firebase/auth.dart';
import 'package:app/models/firebase_user.dart';
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
    return Center(
      child: Card(
        child: SizedBox(
          width: 400,
          child: FutureBuilder<FirebaseUser?>(
            future: userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final user = snapshot.data;

                return Row(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Container(
                        color: const Color.fromARGB(
                            255, 0, 0, 0), // Placeholder for an image or avatar
                      ),
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.firstName ?? 'No First Name', style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 20),
                        if (user!.friends.isNotEmpty)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: user.friends.map((friend) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  friend.summary,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                    const Spacer(),
                  ],
                );
              } else {
                return const Text('No user data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
