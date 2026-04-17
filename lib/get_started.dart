import 'package:book_app/sign_in.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: Image.asset('assets/images/logo2.png')),
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.brown.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Let's Read!",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.brown.shade500,
                    ),
                  ),
                ),
                const SizedBox(height: 140),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: Container(
                      width: 324,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffA78D78),
                        borderRadius: BorderRadius.circular(51),
                      ),
                      child: const Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
