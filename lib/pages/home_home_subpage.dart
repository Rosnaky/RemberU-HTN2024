import 'package:app/widgets/user_card_list.dart';
import 'package:flutter/material.dart';

class HomeHomeSubpage extends StatefulWidget {
  const HomeHomeSubpage({super.key});

  @override
  State<HomeHomeSubpage> createState() => _HomeHomeSubpageState();
}

class _HomeHomeSubpageState extends State<HomeHomeSubpage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [UserCardList()],
    );
  }
}
