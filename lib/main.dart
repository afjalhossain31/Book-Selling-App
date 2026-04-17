import 'package:book_app/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LeatsRead());
}

class LeatsRead extends StatelessWidget {
  const LeatsRead({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.brown.shade800),
      ),
      home: const Splash(),
    );
  }
}
