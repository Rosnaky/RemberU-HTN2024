import 'package:app/app.dart';
import 'package:app/firebase_options.dart';
import 'package:app/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await dotenv.load(fileName: "assets/env");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()..refreshUser()),
  ], child: const htn2024()));
}
