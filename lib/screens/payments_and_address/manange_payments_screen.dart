import 'package:flutter/material.dart';

class ManagePaymentScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {
      "type": "Credit Card",
      "maskedNumber": "**** **** **** 1234",
      "name": "John Doe",
      "isDefault": "true"
    },
    {
      "type": "UPI",
      "maskedNumber": "john.doe@upi",
      "name": "John’s UPI",
      "isDefault": "false"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Payment Methods", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                final isDefault = method["isDefault"] == "true";
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(method["type"]!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: 6),
                        Text(method["maskedNumber"]!, style: TextStyle(fontSize: 14)),
                        SizedBox(height: 4),
                        Text(method["name"]!, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDefault
                                ? Chip(
                              label: Text("Default", style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            )
                                : TextButton(
                              onPressed: () {
                                // Set default logic
                              },
                              child: Text("Set as Default"),
                            ),
                            IconButton(
                              onPressed: () {
                                // Delete logic
                              },
                              icon: Icon(Icons.delete_outline, color: Colors.red),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add New Method Button
          SafeArea(
            minimum: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Show Add Payment Method form/screen
                },
                icon: Icon(Icons.add_card),
                label: Text("Add New Payment Method", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
