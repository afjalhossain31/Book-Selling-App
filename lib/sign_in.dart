import 'package:book_app/forget.dart';
import 'package:book_app/bottom_bar.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Input fields er text control korar jonno controllers
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  // Sign-in logic: ekhane email ebong password check kora hoy
  void _handleSignIn() {
    String email = emailText.text.trim();
    String password = passwordText.text.trim();

    // Field khali thakle warning debe
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }
    

    // Valid user home page (BottomBar) e niye jabe
    if (email == "user@gmail.com" && password == "123456") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    } else {
      // Vul password hole error dekhabe
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
    }
  }

  // Memory leak bachanir jonno dispose kora hoiche
  @override
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // Prothom ongsho: Logo/Image
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
              // Dwitiyo part: Login Form
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    // Email Input Field
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
                    // Password Input Field
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
                    const SizedBox(height: 10),
                    // Forget Password Link
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Forget(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Sign In Button
                    InkWell(
                      onTap: _handleSignIn,
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xffA78D78),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
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
              const Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}

