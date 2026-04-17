import 'package:book_app/cart.dart';
import 'package:book_app/category.dart';
import 'package:book_app/home.dart';
import 'package:book_app/menu.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  final List<Widget> screens = [
    const Home(),
    const Category(),
    const Cart(), // Dynamic data charai default Cart dekhabe
    const Menu()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.brown.shade200,
          backgroundColor: Colors.grey.shade200,
        ),

        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },

          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
              icon: Icon(Icons.category),
              label: "Category",
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            NavigationDestination(icon: Icon(Icons.menu), label: "Menu"),
          ],
        ),
      ),
    );
  }
}
