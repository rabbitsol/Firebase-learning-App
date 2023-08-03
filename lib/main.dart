import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselearningapp/firebase_options.dart';
import 'package:firebaselearningapp/ui/splach_screen.dart';
import 'package:flutter/material.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized;
//   // await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
