import 'package:book_app/home.dart';
import 'package:flutter/material.dart';

class Forget extends StatelessWidget {
  const Forget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Home();
                },
              ),
            );
          },

          child: Container(
            width: 200,
            height: 100,
            color: Colors.green,
            child: Center(
              child: Text(
                "Tap To continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
