import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = "/";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Scaffold(
              body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome to",
                        overflow: TextOverflow.visible,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w300)),
                    Text("*App Name*",
                        overflow: TextOverflow.visible,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary)),
                    SizedBox(height: height * 0.1),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Never forget a person ever again",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.15),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context,
                              snapshot.hasData
                                  ? HomePage.routeName
                                  : LoginPage.routeName);
                        },
                        child: snapshot.hasData
                            ? const Text("Enter")
                            : const Text("Login"))
                  ],
                ),
              ),
            ],
          ));
        });
  }
}
