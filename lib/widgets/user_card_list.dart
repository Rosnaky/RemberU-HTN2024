import 'package:app/provider/user_provider.dart';
import 'package:app/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Builder(builder: (context) {
      return Column(
          children: userProvider.user?.friends
                  .map((e) => UserCard(uid: e))
                  .toList() ??
              []);
    });
  }
}
