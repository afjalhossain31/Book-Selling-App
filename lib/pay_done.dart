import 'package:book_app/bottom_bar.dart';
import 'package:book_app/cart_manager.dart';
import 'package:flutter/material.dart';

class PayDone extends StatelessWidget {
  const PayDone({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        // 👈 takes full screen space
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 👈 keeps content compact
            children: [
              Image.asset("assets/images/tick.png", width: 150, height: 150),

              const SizedBox(height: 20),

              const Text("We received your payment successfully."),
              const Text("Thanks for shopping!"),

              const SizedBox(height: 40),

              InkWell(
                onTap: () {
                  // [LOGIC]: Checkout confirm hoile Cart empty kore dewa uchit
                  CartManager().clearCart();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BottomBar()),
                    (route) => false,
                  );
                },

                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Center(
                    child: Text(
                      "Tap to Continue",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
