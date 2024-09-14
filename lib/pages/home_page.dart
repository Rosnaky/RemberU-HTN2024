import 'package:app/pages/home_home_subpage.dart';
import 'package:app/widgets/bottom_navigation_bar.dart';
import 'package:app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeHomeSubpage();
      default:
        return HomeHomeSubpage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: 0,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          body: Column(
            children: [
              TopBar(
                constraints: constraints,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              _getPage(selectedIndex)
            ],
          ));
    });
  }
}
