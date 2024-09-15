import 'package:app/firebase/auth.dart';
import 'package:app/firebase/firebase_storage_image.dart';
import 'package:app/models/firebase_user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserCard extends StatefulWidget {
  const UserCard(
      {super.key,
      required this.name,
      required this.summary,
      required this.lastSeen,
      required this.url});

  final String name;
  final String summary;
  final String lastSeen;
  final String url;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String get url => widget.url;
  String get name => widget.name;
  String get summary => widget.summary;
  String get lastSeen => widget.lastSeen;
  late Future<FirebaseUser?> userFuture;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
  }

  Future<String> getDownloadURL() async {
    final ref = FirebaseStorage.instance.ref().child('photos').child(url);
    var downloadurl = await ref.getDownloadURL();
    return downloadurl;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Center(
        child: Card(
            child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xffD3EAF2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          child: Container(
              margin: const EdgeInsets.all(8.0), // Space outside the box
              // color: const Color.fromARGB(48, 143, 221, 239),
              width: 400,
              child: Row(children: [
                FutureBuilder<String>(
                    future: getDownloadURL(),
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.network(snapshot.data!),
                      );
                    }),
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
                Container(
                    width: 250,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          softWrap: true,
                        ), // will have to change to what's said during the convo
                        const SizedBox(height: 10),
                        Text(
                          summary,
                          softWrap: true,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Last seen on " +
                              DateFormat('MMMM dd y')
                                  .format(DateTime.parse(lastSeen)),
                          softWrap: true,
                        )
                      ],
                    )),
                // const Spacer(),
              ])),
        ),
      ),
    )));
  }
}
