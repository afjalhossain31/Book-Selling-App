import 'package:book_app/cart.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  final Map<String, String> book; // Boiyer data dhorar jonno variable

  const BookDetails({super.key, required this.book}); // Constructor-e data nissi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("9:41", style: TextStyle(fontSize: 14)),
            Text(
              book["title"] ?? "Book Details", // Dynamic title
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: SizedBox(
                height: 250,
                width: 200,
                child: Image.asset(book["image"] ?? "assets/images/b1.jpg", fit: BoxFit.contain), // Dynamic image
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "এই বইটি একটি চমৎকার সাহিত্য কর্ম। এর কাহিনী পাঠককে বিমোহিত করবে। "
                "বইটির লেখক চমৎকারভাবে চরিত্রগুলো ফুটিয়ে তুলেছেন যা অত্যন্ত প্রশংসনীয়।", // Background description (Apatoto generic)
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Text(
              "Author: ${book["author"] ?? "Unknown"}", // Dynamic author
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: ${book["price"] ?? "0.0"}", // Dynamic price
              style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Rating: 4.8/5",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  // [LOGIC]: Selected boiyer data Cart page-e pathano hosse jeno price thikmoto calculate hoy
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Cart(book: book);
                      },
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffA78D78),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Add To Cart",
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

