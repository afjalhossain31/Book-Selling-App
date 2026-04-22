import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_app/book_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  String _searchKeyword = "";

  // Static list for local books (optional, used by Latest/Upcoming)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff8B5E34),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "9:30 AM",
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
            /// SEARCH BAR / section
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    _searchKeyword = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search by title or author",
                  filled: true,
                  fillColor: Colors.grey[300],
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            /// FEATURE CARD (CLICKABLE IMAGE)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 131, 118, 198),
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
                              builder: (context) => const BookDetails(book: {
                                "image": "assets/images/b1.jpg",
                                "title": "বাংলা উপন্যাস বই",
                                "author": "Novel Author",
                                "price": "\$33.00",
                              }),
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
                            const Text(
                              "Novel",
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "বাংলা উপন্যাস বই",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "\$33.00",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text("12% off"),
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

            const SizedBox(height: 20),

            sectionTitle("Books from Firebase"),

            // StreamBuilder: Firestore-er 'books' collection theke live data load korar jonno add kora hoyeche
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('books').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Data load hoyar somoy loader dekhabe
                }

                // Firestore theke data niye asha hochche
                final allDocs = snapshot.data!.docs;
                
                // Search keyword-er upor base kore book-gulo filter kora hochche
                final filteredDocs = allDocs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final title = (data['title'] ?? "").toString().toLowerCase();
                  final author = (data['author'] ?? "").toString().toLowerCase();
                  return title.contains(_searchKeyword) ||
                      author.contains(_searchKeyword);
                }).toList();

                if (filteredDocs.isEmpty) {
                  return const Center(child: Text("No books found"));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredDocs.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final data = filteredDocs[index].data() as Map<String, dynamic>;
                      
                      // dynamic data-ke String map-e convert kora hochche jate UI function accept kore
                      final bookMap = {
                        "image": (data['image'] ?? "assets/images/b1.jpg").toString(),
                        "title": (data['title'] ?? "Untitled").toString(),
                        "author": (data['author'] ?? "Unknown").toString(),
                        "price": (data['price'] ?? "0.00").toString(),
                      };
                      return bookCard(bookMap);
                    },
                  ),
                );
              },
            ),

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

  Widget bookCard(Map<String, String> book) {
    // Image URL check korchi, jate Network image naki Asset image seta bujha jay
    bool isNetworkImage = book["image"]!.startsWith('http');

    return InkWell(
      onTap: () {
        // Je boiye click korbo, shei boiyer data mapping kore details-e pass korsi
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(book: book),
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
                child: isNetworkImage
                    ? Image.network(book["image"]!, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/b1.jpg", fit: BoxFit.cover);
                      })
                    : Image.asset(book["image"]!, fit: BoxFit.cover),
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
                    book["title"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    book["author"]!,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    book["price"]!,
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
