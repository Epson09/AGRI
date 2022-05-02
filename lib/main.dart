import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp_app/pages/loginPage.dart';
import 'package:tp_app/pages/splashScreen.dart';
import 'package:tp_app/service/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // options: FirebaseOptions(
  //   apiKey: "", appId: "", messagingSenderId: "", projectId: ""));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          "/login": (context) => const LoginScreen(),
        });
  }
}
