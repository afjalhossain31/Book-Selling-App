import 'package:book_app/pay_done.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int selectedIndex = -1;

  final List<Map<String, String>> methods = [
    {"image": "assets/images/bkash.jpeg", "name": "bKash"},
    {"image": "assets/images/nogod.jpeg", "name": "Nagad"},
    {"image": "assets/images/rocket.jpeg", "name": "Rocket"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA78D78),
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("9:41", style: TextStyle(fontSize: 14)),
            const Text("Payment Method",
                style: TextStyle(color: Colors.white, fontSize: 18)),
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

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mobile Banking",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),

            SizedBox(height: 15),

            /// 🔲 GRID VIEW
            GridView.builder(
              shrinkWrap: true,
              itemCount: methods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.brown : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 8, color: Colors.black26),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(methods[index]["image"]!, height: 50),

                        SizedBox(height: 10),

                        Text(methods[index]["name"]!),

                        /// selection indicator
                        if (isSelected)
                          Icon(Icons.check_circle, color: Colors.brown),
                      ],
                    ),
                  ),
                );
              },
            ),

            Spacer(),

            /// ✅ CONFIRM BUTTON
            InkWell(
              onTap: () {
                if (selectedIndex == -1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a payment method")),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PayDone()),
                );
              },

              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffA78D78),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
