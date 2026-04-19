import 'package:book_app/cart_manager.dart';
import 'package:book_app/payment.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final Map<String, String>? book; // Cart e add kora book er data jodi direct pass kora hoy

  const Cart({super.key, this.book}); // Constructor jekhane book data optional hisabe pass kora jete pare

  @override
  State<Cart> createState() => _CartState(); 
}

class _CartState extends State<Cart> {
  @override
  void initState() { 
    super.initState();
    // Add to cart jodi direct pass kora hoy 
    if (widget.book != null) { // Jodi book data pass kora hoy, tahole seta cart e add kore dey
    // null check kore book data ke addToCart method e pass kora hoy
      CartManager().addToCart(widget.book!); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager().items; // CartManager theke cart items gula ke access kore dey
    double subtotal = CartManager().calculateSubtotal(); // CartManager theke subtotal calculate kore dey
    double shippingFee = cartItems.isEmpty ? 0.0 : 70.0;
    double total = subtotal + shippingFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("9:41", style: TextStyle(fontSize: 14)),
            const Text("Your Cart", style: TextStyle(color: Colors.white, fontSize: 18)),
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
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          height: 100,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(item["image"]!, height: 80, width: 60, fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item["title"]!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item["price"]!,
                                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white70),
                                onPressed: () {
                                  setState(() {
                                    cartItems.removeAt(index);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order Summary :",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 22),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal:", style: TextStyle(fontSize: 18)),
                          Text("${subtotal.toStringAsFixed(2)} Tk", style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Shipping fee:", style: TextStyle(fontSize: 18)),
                          Text("${shippingFee.toStringAsFixed(2)} Tk", style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                            "${total.toStringAsFixed(2)} Tk",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Payment()));
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
                              "Checkout",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

