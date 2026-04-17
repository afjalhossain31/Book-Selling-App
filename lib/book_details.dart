import 'package:book_app/cart.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});
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
            const Text(
              "Book Details",
              style: TextStyle(color: Colors.white, fontSize: 18),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/images/b1.jpg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "‘ওমর’ একটি ঐতিহাসিক গ্রন্থ যেখানে ইসলামের দ্বিতীয় খলিফা হযরত উমর (রাঃ)-এর জীবন, শাসনব্যবস্থা এবং ন্যায়পরায়ণতার কাহিনী বর্ণনা করা হয়েছে। "
              "তিনি ইসলামের ইতিহাসে অন্যতম গুরুত্বপূর্ণ ব্যক্তিত্ব, যিনি তাঁর ন্যায়বিচার, সাহসিকতা এবং প্রশাসনিক দক্ষতার জন্য পরিচিত। "
              "তার শাসনামলে ইসলামি সাম্রাজ্য ব্যাপকভাবে বিস্তৃত হয় এবং সমাজে ন্যায় ও শৃঙ্খলা প্রতিষ্ঠিত হয়।",
            ),
          ),

          Text(
            "Author: বিভিন্ন ইতিহাসবিদ",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),

          Text(
            "Category: ইতিহাস",
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),

          Text(
            "Rating: 4.7/5",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),

          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Cart();
                    },
                  ),
                );
              },

              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffA78D78),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
