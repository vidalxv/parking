import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking/pages/login_page.dart';
import './themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCpSbUs_N6J58qWrl6K_RnD6fl6v9gIKMU",
      authDomain: "estacionamento-web.firebaseapp.com",
      projectId: "estacionamento-web",
      storageBucket: "estacionamento-web.appspot.com",
      messagingSenderId: "244370712518",
      appId: "1:244370712518:web:0b498b8090794a3c3cb4c7"
    ),
  ); 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: customTheme,
    );
  }
}


