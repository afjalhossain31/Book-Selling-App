import 'package:book_app/sign_in.dart';
import 'package:book_app/profile.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.person, color: Colors.black, size: 30),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Profile();
                      },
                    ),
                  );
                },
                child: const Text("Profile", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.language, color: Colors.green, size: 30),
              ),
              Text("Language", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.orange,
                  size: 30,
                ),
              ),
              Text("Notofication", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.dark_mode, color: Colors.black, size: 30),
              ),
              Text("Dark mood", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_box_outlined,
                  color: Colors.teal,
                  size: 30,
                ),
              ),
              Text("About us", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.download, color: Colors.teal, size: 30),
              ),
              Text("Downloads", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.privacy_tip, color: Colors.red, size: 30),
              ),
              Text("Privacy", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.help, color: Colors.green, size: 30),
              ),
              Text("Help", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout, color: Colors.blue, size: 30),
              ),
              Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignIn();
                          },
                        ),
                      );
                    },

                    child: Text("LOGOUT", style: TextStyle(fontSize: 20)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
