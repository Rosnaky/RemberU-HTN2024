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
    return Column(
      children: [
        // Container to create a box around the text
        Container(
          padding: const EdgeInsets.all(16.0),  // Padding inside the box
          margin: const EdgeInsets.all(8.0),   // Space outside the box
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 208, 221, 243),  // Background color of the box
            borderRadius: BorderRadius.circular(12.0),  // Rounded corners
          ),
          child: const Text(
            "Meet your friends",
            style: TextStyle(fontSize: 18.0),  // You can style the text as needed
          ),
        ),
        // The UserCardList widget remains unchanged
        const UserCardList(),
      ],
    );
  }
}