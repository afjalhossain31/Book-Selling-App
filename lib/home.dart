import 'package:flutter/material.dart';
import 'package:book_app/book_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Amader kache thaka shob boiyer main list 
  final List<Map<String, String>> books = [
    {
      "image": "assets/images/b1.jpg",
      "title": "বাংলা উপন্যাস",
      "author": "Author 1",
      "price": "\$25.00",
      "isbn": "123-456",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Novel Book",
      "author": "Author 2",
      "price": "\$30.00",
      "isbn": "789-012",
    },
    {
      "image": "assets/images/b3.jpeg",
      "title": "Spring Story",
      "author": "Author 3",
      "price": "\$20.00",
      "isbn": "345-678",
    },
    {
      "image": "assets/images/b4.jpeg",
      "title": "Himu",
      "author": "Humayun Ahmed",
      "price": "\$18.00",
      "isbn": "901-234",
    },
  ];

  // Screen-e jeta display korbo sheita filtered list create korlam
  List<Map<String, String>> filteredBooks = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // App start haoyar shomoy shuru-te shob boi-e dekhabe
    filteredBooks = List.from(books);
  }

  // Search filter korar jonno logic add korlam
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      // Jodi search box faka thake, taile main list results-e rakhbo
      results = books;
    } else {
      // Boiyer Title, Author ba ISBN-er sathe match korle results list-e add korsi
      results = books
          .where((book) =>
              book["title"]!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              book["author"]!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              book["isbn"]!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Search results peye gele state/UI update korar jonno setState use korsi
    setState(() {
      filteredBooks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff8B5E34),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "9:41",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (value) => _runFilter(value), // Proti word type korlei filter hobe
                decoration: InputDecoration(
                  hintText: "Search by title, author or ISBN",
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
                itemCount: filteredBooks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return bookCard(filteredBooks[index]);
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
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          return bookCard(filteredBooks[index]);
        },
      ),
    );
  }

  Widget bookCard(Map book) {
    return InkWell(
      onTap: () {
        // [NAVIGATION LOGIC]: Boiyer upore click korle detail page-e niye jabe
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BookDetails(),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xff8B5E34),
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
                  const Text("Classics",
                      style: TextStyle(color: Colors.white70)),
                  Text(
                    book["title"],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    book["author"],
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    book["price"],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
