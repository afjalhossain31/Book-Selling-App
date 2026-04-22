import 'package:book_app/forget.dart';
import 'package:book_app/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth package import kora hoyeche
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
  bool _isLoading = false; // Loading state check korar jonno variable add kora hoyeche

  // Sign-in logic: Firebase Authentication diye login check kora hoy
  Future<void> _handleSignIn() async {
    String email = emailText.text.trim();
    String password = passwordText.text.trim();

    // Field khali thakle warning debe
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Login shuru hole loader dekhabe
    });

    try {
      // Firebase Authentication diye login kora hochche
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // Login hoye gele home page e niye jabe
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    } on FirebaseAuthException catch (e) {
      // Firebase error gulo handle kora hochche
      String errorMessage = "Login failed";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else if (e.code == 'user-disabled') {
        errorMessage = "This user has been disabled.";
      }
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // Kaj shesh hole loader bondho hobe
        });
      }
    }
  }

  // Handle Registration: Notun user create korar jonno logic add kora hoyeche
  Future<void> _handleSignUp() async {
    String email = emailText.text.trim();
    String password = passwordText.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Firebase-e notun user create kora hochche
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful!")),
      );
      
      // Registration successful holeo home e jabe
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed: ${e.message}"; // Firebase ki bolche seta clear dekhabe
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      }
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), duration: const Duration(seconds: 4)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
                      onTap: _isLoading ? null : _handleSignIn,
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xffA78D78),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
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
                    const SizedBox(height: 15),
                    // Don't have an account? Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xffA78D78),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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

