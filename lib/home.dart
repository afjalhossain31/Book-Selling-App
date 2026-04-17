import 'package:flutter/material.dart';
import 'package:book_app/book_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List books = [
    {
      "image": "assets/images/b1.jpg",
      "title": "বাংলা উপন্যাস",
      "author": "Author 1",
      "price": "\$25.00",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Novel Book",
      "author": "Author 2",
      "price": "\$30.00",
    },
    {
      "image": "assets/images/b3.jpeg",
      "title": "Spring Story",
      "author": "Author 3",
      "price": "\$20.00",
    },
    {
      "image": "assets/images/b4.jpeg",
      "title": "Himu",
      "author": "Humayun Ahmed",
      "price": "\$18.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xff8B5E34),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Happy reading",
                  filled: true,
                  fillColor: Colors.grey[300],
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            /// 📚 FEATURE CARD (CLICKABLE IMAGE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 131, 118, 198),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookDetails(),
                            ),
                          );
                        },
                        child: Image.asset("assets/images/b1.jpg"),
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Novel",
                              style: TextStyle(color: Colors.white70),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "বাংলা উপন্যাস বই",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),

                            Spacer(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$33.00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text("12% off"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            sectionTitle("Top Books"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return bookCard(books[index]);
                },
              ),
            ),

            const SizedBox(height: 20),

            sectionTitle("Latest Books"),
            horizontalBooks(),

            const SizedBox(height: 20),

            sectionTitle("Upcoming Books"),
            horizontalBooks(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text("see more"),
        ],
      ),
    );
  }

  Widget horizontalBooks() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return bookCard(books[index]);
        },
      ),
    );
  }

  Widget bookCard(Map book) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xff8B5E34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(book["image"], fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Classics", style: TextStyle(color: Colors.white70)),
                Text(
                  book["title"],
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  book["author"],
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 5),
                Text(
                  book["price"],
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
