import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  static const List<Map<String, String>> categories = [
    {
      "image": "assets/images/b3.jpeg",
      "title": "Fiction",
      "subtitle": "Story based books",
    },
    {
      "image": "assets/images/b4.jpeg",
      "title": "Crime",
      "subtitle": "Mystery & thriller",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Fantasy",
      "subtitle": "Magic & adventure",
    },
    {
      "image": "assets/images/b1.jpg",
      "title": "Drama",
      "subtitle": "Emotional stories",
    },
    {
      "image": "assets/images/b1.jpg",
      "title": "Horror",
      "subtitle": "Scary stories",
    },
    {
      "image": "assets/images/b2.jpeg",
      "title": "Language",
      "subtitle": "Learn languages",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book category", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),

        /// 🔲 GRID VIEW
        child: GridView.builder(
          itemCount: categories.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // 👈 controls height/width ratio
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
                  /// 📸 IMAGE (FIXED - NO CROP)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      categories[index]["image"]!,
                      height: 80,
                      fit: BoxFit.contain, // 👈 KEY FIX
                    ),
                  ),

                  /// 📚 TITLE
                  Text(
                    categories[index]["title"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 5),

                  /// 📝 SUBTITLE
                  Text(
                    categories[index]["subtitle"]!,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
