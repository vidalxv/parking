import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking/pages/login_page.dart';
import './themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
