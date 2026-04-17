import 'package:book_app/forget.dart';
import 'package:book_app/bottom_bar.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    var emailText = TextEditingController();
    var passwordText = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset("assets/images/signin.png"),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.brown,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 50,
                  width: 300,
                  child: TextField(
                    controller: passwordText,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Colors.brown,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: Colors.black87),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Forget()),
                    );
                  },
                  child: const Text(
                    "Forget password?",
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                const SizedBox(height: 28),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBar(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xffA78D78),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(flex: 1, child: Row()),
        ],
      ),
    );
  }
}
