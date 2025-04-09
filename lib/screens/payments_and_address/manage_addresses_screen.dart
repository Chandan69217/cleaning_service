import 'package:flutter/material.dart';

class ManageAddressesScreen extends StatelessWidget {
  final List<Map<String, String>> addressList = [
    {
      "name": "John Doe",
      "phone": "+91 9876543210",
      "address": "123, MG Road, Bangalore, Karnataka - 560001",
    },
    {
      "name": "Anjali Sharma",
      "phone": "+91 9988776655",
      "address": "Flat 12B, Green Heights, Delhi - 110045",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Addresses", style: TextStyle(color: Colors.black)),
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
              itemCount: addressList.length,
              itemBuilder: (context, index) {
                final address = addressList[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address["name"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(address["phone"]!, style: TextStyle(color: Colors.grey[700])),
                        SizedBox(height: 8),
                        Text(address["address"]!, style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.edit, size: 18),
                              label: Text("Edit"),
                            ),
                            SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.delete_outline, size: 18, color: Colors.red),
                              label: Text("Delete", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add Address Button
          SafeArea(
            minimum: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Show bottom sheet or navigate to address form
                },
                icon: Icon(Icons.add_location_alt_outlined),
                label: Text("Add New Address", style: TextStyle(fontSize: 16)),
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
