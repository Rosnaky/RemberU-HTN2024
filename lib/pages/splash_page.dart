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
                    Image.asset(
                      'assets/images/logo-slogan.png',
                      width: width * 0.7,
                      height: height * 0.2,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 0),
                    Image.asset(
                      'assets/images/bear.png',
                      width: width * 0.4,
                      height: height * 0.5,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: height * 0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          snapshot.hasData
                              ? HomePage.routeName
                              : LoginPage.routeName,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 109, 198, 225),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: snapshot.hasData
                          ? const Text("Enter")
                          : const Text("Begin",
                              style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}