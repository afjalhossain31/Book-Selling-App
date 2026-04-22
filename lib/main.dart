import 'package:book_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// App er entry point /main function
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase initialize kora hocche
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LeatsRead());
}

// Main App Widget (StatelessWidget)
class LeatsRead extends StatelessWidget {
  const LeatsRead({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Debug banner bondho korar jonno
      debugShowCheckedModeBanner: false,
      
      // App er theme settings
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.brown.shade800),
      ),
      
      // App start hole prothome Splash Screen dekhabe
      home: const Splash(),
    );
  }
}
