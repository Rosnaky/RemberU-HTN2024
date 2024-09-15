import 'dart:math';

import 'package:app/provider/user_provider.dart';
import 'package:app/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserCardList extends StatefulWidget {
  const UserCardList({super.key});

  @override
  State<UserCardList> createState() => _UserCardListState();
}

class _UserCardListState extends State<UserCardList> {
  @override
  void initState() {
    super.initState();
    // Fetch user details when the widget is initialized
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Container(
        child: Column(
            children: userProvider.user?.friends
                    .map((e) => UserCard(
                        name: e.name,
                        summary: e.summary,
                        lastSeen: e.lastSeen.toString(),
                        url: e.photoUrl.length == 0
                            ? "https://static.vecteezy.com/system/resources/previews/036/280/651/non_2x/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"
                            : e.photoUrl[Random().nextInt(e.photoUrl.length)]))
                    .toList() ??
                []));
  }

  // @override
  // Widget build(BuildContext context) {
  //   final userProvider = Provider.of<UserProvider>(context);
  //   return Builder(builder: (context) {
  //     return Column(
  //         children: userProvider.user?.friends
  //                 .map((e) => UserCard(name: e.name, summary: e.summary))
  //                 .toList() ??
  //             []);
  //   });
  // }
}
