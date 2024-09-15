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
        child: Container (
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color:  Color(0xffD3EAF2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              child: Container (
          margin: const EdgeInsets.all(8.0),   // Space outside the box
                // color: const Color.fromARGB(48, 143, 221, 239),
                  width: 400,
                  child: Row(children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Container(
                        color: const Color(0xffE4F2F7), // Placeholder for an image or avatar
                ),
          ),
          // width: 400,
          // child: Row(children: [
          //   SizedBox(
          //     width: 150,
          //     height: 150,
          //     child: Container(
          //       color: const Color.fromARGB(
          //           255, 0, 0, 0), // Placeholder for an image or avatar
          //     ),
            // ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, 
                    softWrap: true,
                  ), // will have to change to what's said during the convo
                  const SizedBox(height:10),
                  Text(
                    summary, 
                    softWrap: true,
                  ),
                ],
            )),
            // const Spacer(),
          ])),
        ),
      ),
    )));
  }
}
