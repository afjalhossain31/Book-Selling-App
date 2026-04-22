import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // Category-r main list (Eikhane boiyer details add kora jabe jeno search e pawa jay)
  static const List<Map<String, String>> allCategories = [
    {
      "image": "assets/images/b3.jpeg",
      "title": "Fiction",
      "subtitle": "Story based books",
      "author": "Humayun Ahmed, Rabindranath",
      "isbn": "111-222",
    },
    {
      "image": "assets/images/b4.jpeg",
      "title": "Crime",
      "subtitle": "Mystery & thriller",
      "author": "Rakib Hasan",
      "isbn": "333-444",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Fantasy",
      "subtitle": "Magic & adventure",
      "author": "J.K. Rowling",
      "isbn": "555-666",
    },
    {
      "image": "assets/images/b1.jpg",
      "title": "Drama",
      "subtitle": "Emotional stories",
      "author": "Sarat Chandra",
      "isbn": "777-888",
    },
    {
      "image": "assets/images/b1.jpg",
      "title": "Horror",
      "subtitle": "Scary stories",
      "author": "Bibhutibhushan",
      "isbn": "999-000",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Language",
      "subtitle": "Learn languages",
      "author": "Various Authors",
      "isbn": "121-212",
    },
  ];

  // Search er por jeta dekhabo shei list
  List<Map<String, 
  String>> displayedCategories = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Shurute shob gulai dekhabe
    displayedCategories = List.from(allCategories);
  }

  // Search engine logic: keyword match korle categorized results filter kore
  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      // Search faka hole shob category dekhabe
      results = allCategories;
    } else {
      
      // Title, Subtitle, Author ba ISBN jekonotar sathe match korlei shera result nilam
      results = allCategories
          .where((cat) =>
              cat["title"]!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              cat["subtitle"]!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              (cat["author"] != null && cat["author"]!.toLowerCase().contains(enteredKeyword.toLowerCase())) ||
              (cat["isbn"] != null && cat["isbn"]!.toLowerCase().contains(enteredKeyword.toLowerCase())))
          .toList();
    }

    // List update kore UI rebuild korsi
    setState(() {
      displayedCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("9:41", style: TextStyle(fontSize: 14)),
            const Text("Book category", style: TextStyle(color: Colors.white, fontSize: 18)),
            Row(
              children: const [
                Icon(Icons.wifi, size: 16),
                SizedBox(width: 5),
                Icon(Icons.battery_full, size: 16),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          /// 🔍 SEARCH BAR (Home page er moto)
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: "Search by title, author or ISBN",
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),

              /// 🔲 GRID VIEW
              child: GridView.builder(
                itemCount: displayedCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.brown.shade500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// 📸 IMAGE
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            displayedCategories[index]["image"]!,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),

                        /// 📚 TITLE
                        Text(
                          displayedCategories[index]["title"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(height: 5),

                        /// 📝 SUBTITLE
                        Text(
                          displayedCategories[index]["subtitle"]!,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

