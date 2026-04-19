import 'package:book_app/successfully_post.dart';
import 'package:flutter/material.dart';

class AddBookForm extends StatefulWidget {
  const AddBookForm({super.key});

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Add New Book", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Book Image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUploadOption(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () {
                    // Logic for gallery upload
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gallery opened")),
                    );
                  },
                ),
                _buildUploadOption(
                  icon: Icons.camera_alt,
                  label: "Take Photo",
                  onTap: () {
                    // Logic for camera capture
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Camera opened")),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField("Book Title", "Enter book name"),
            const SizedBox(height: 15),
            _buildTextField("Author Name", "Enter author name"),
            const SizedBox(height: 15),
            _buildTextField("Price", "Enter price (e.g. 500 Tk)", isNumber: true),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuccessfullyPost()),
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
                      "Post Now",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.brown.withOpacity(0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.brown),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
      ],
    );
  }
}
