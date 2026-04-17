import 'package:flutter/material.dart';

class BookTypeWidget extends StatelessWidget {
  final String bookType; // cls er nam r consturctre name SAME HBE NA
  final bool isSelected; //bool constructr for selected clr
  final VoidCallback onTap;

  const BookTypeWidget({
    super.key,

    ///class name
    required this.bookType, //***constructure making
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // now editing all cmponent together
    return GestureDetector(
      ///***selection functional korar jonno
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),

        /// constructre call, data pass korbo main page theke
        child: Text(
          bookType,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.teal : Colors.black,
          ),
        ),
      ),
    );
  }
}
