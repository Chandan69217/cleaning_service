import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verified Customer',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                '+91 8969893457',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Grid of cards
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard(Icons.content_paste, 'My bookings'),
                _buildCard(Icons.devices, 'Native devices'),
                _buildCard(Icons.headset, 'Help & support'),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          // List of items
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildListItem(Icons.description, 'My Plans'),
                      _buildListItem(Icons.account_balance_wallet, 'Wallet'),
                      _buildListItem(Icons.account_balance, 'Plus membership'),
                      _buildListItem(Icons.star, 'My rating'),
                      _buildListItem(Icons.location_on, 'Manage addresses'),
                      _buildListItem(Icons.credit_card, 'Manage payment methods'),
                      _buildListItem(Icons.settings, 'Settings'),
                      _buildListItem(Icons.info, 'About UC'),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFFD32F2F),
                        side: BorderSide(color: Color(0xFFD32F2F)),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('Logout', style: TextStyle(color: Color(0xFFD32F2F))),
                    ),
                  ),
                  Spacer(),
                  // Footer
                  Text('Version 7.5.91 R455', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0,),
                ],
              ),
            ),
          ),
          // Logout Button
        ],
      ),
    );
  }

  // Helper method to build cards
  Widget _buildCard(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1,child: Icon(icon, size: 24)),
          SizedBox(height: 20),
          Expanded(flex: 2,child: Text(label, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold,fontSize: 16.0))),
        ],
      ),
    );
  }

  // Helper method to build list items
  Widget _buildListItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(label, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
