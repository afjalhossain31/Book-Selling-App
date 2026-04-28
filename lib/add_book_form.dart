import 'package:book_app/successfully_post.dart';
import 'package:flutter/foundation.dart'; // Web check korar jonno
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Storage-er jonno
import 'package:image_picker/image_picker.dart'; // Image select korar jonno

class AddBookForm extends StatefulWidget {
  const AddBookForm({super.key});

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isLoading = false;
  XFile? _selectedImage; // Select kora image rakhar jonno
  final ImagePicker _picker = ImagePicker();

  // Image select korar function

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  // Image Firebase Storage-e upload kore URL neyar function
  Future<String?> _uploadImage(XFile image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child('book_images').child(fileName);
      
      UploadTask uploadTask;
      if (kIsWeb) {
        // Web-er jonno data format alada hoy
        uploadTask = ref.putData(await image.readAsBytes());
      } else {
        // Mobile-er jonno direct file path
        uploadTask = ref.putData(await image.readAsBytes()); 
      }

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL(); // Uploaded image-er link return korbe
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
  
  // _saveBook function: Firestore database-e boiyer details (Title, Author, Price, Image) joma korar jonno
  Future<void> _saveBook() async {
    // Sob field puron kora hoyeche kina check kora hochche
    if (_titleController.text.isEmpty ||
        _authorController.text.isEmpty ||
        _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _uploadImage(_selectedImage!); // Image upload kore link nichchi
      }

      // Cloud Firestore-er 'books' collection-e data pathano hochche
      await FirebaseFirestore.instance.collection('books').add({
        'title': _titleController.text,
        'author': _authorController.text,
        'price': _priceController.text,
        'image': imageUrl ?? "assets/images/b1.jpg", // Image thakle link, na thakle default image
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SuccessfullyPost()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _priceController.dispose();
    super.dispose();
  }

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
            if (_selectedImage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: kIsWeb 
                      ? Image.network(_selectedImage!.path, height: 150, width: 120, fit: BoxFit.cover)
                      : Image.network(_selectedImage!.path, height: 150, width: 120, fit: BoxFit.cover), 
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUploadOption(
                  icon: Icons.photo_library,
                  label: "Gallery",
                  onTap: () => _pickImage(ImageSource.gallery), // Gallery theke image select
                ),
                _buildUploadOption(
                  icon: Icons.camera_alt,
                  label: "Take Photo",
                  onTap: () => _pickImage(ImageSource.camera), // Camera diye photo tola
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField("Book Title", "Enter book name", controller: _titleController),
            const SizedBox(height: 15),
            _buildTextField("Author Name", "Enter author name", controller: _authorController),
            const SizedBox(height: 15),
            _buildTextField("Price", "Enter price (e.g. 500 Tk)", isNumber: true, controller: _priceController),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: _isLoading ? null : _saveBook,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xffA78D78),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
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

  Widget _buildTextField(String label, String hint, {bool isNumber = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
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
