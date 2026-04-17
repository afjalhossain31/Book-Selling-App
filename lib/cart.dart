import 'package:book_app/payment.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  final Map<String, String>? book; // Nullable kora holo jate direct access kora jay

  const Cart({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    // Default boiyer data jodi kono boi select na kora thake
    final Map<String, String> displayBook = book ?? {
      "image": "assets/images/b1.jpg",
      "title": "Default Book",
      "author": "Unknown Author",
      "price": "0.00 Tk",
    };

    // Price text theke number-e convert kora (e.g., "$25.00" -> 25.0)
    double bookPrice = double.tryParse(displayBook["price"]!.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    double shippingFee = 70.0; // Fixed shipping fee
    double total = bookPrice + shippingFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("9:41", style: TextStyle(fontSize: 14)),
            const Text("Your Cart",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            Row(
              children: const [
                Icon(Icons.wifi, size: 16),
                SizedBox(width: 5),
                Icon(Icons.battery_full, size: 16),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(11),
              ),
              height: 120,
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(displayBook["image"]!, height: 100, width: 70, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayBook["title"]!,
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          displayBook["price"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Summary :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 188, 96, 39),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal:", style: TextStyle(fontSize: 18)),
                    Text(displayBook["price"]!, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping fee:", style: TextStyle(fontSize: 18)),
                    const Text("70.00 Tk", style: TextStyle(fontSize: 18)),
                  ],
                ),
                const Divider(height: 40, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${total.toStringAsFixed(2)} Tk",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                // [NAVIGATION]: Your Cart page theke Payment process shuru korar logic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Payment();
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xffA78D78),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Checkout", // Order complete korar prothom dhap
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

