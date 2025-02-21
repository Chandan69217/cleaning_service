import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/material.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSizeScaling = screenWidth / 375;

    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verified Customer',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22 * fontSizeScaling,
                ),
              ),
              Text(
                '+91 8969893457',
                style: TextStyle(fontSize: 14 * fontSizeScaling, color: Colors.grey),
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
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: screenWidth * 0.02,
              mainAxisSpacing: screenHeight * 0.02,
              children: [
                _buildCard(Icons.content_paste, 'My bookings', fontSizeScaling),
                _buildCard(Icons.devices, 'Native devices', fontSizeScaling),
                _buildCard(Icons.headset, 'Help & support', fontSizeScaling),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildListItem(Icons.description, 'My Plans', fontSizeScaling),
                      _buildListItem(Icons.account_balance_wallet, 'Wallet', fontSizeScaling),
                      _buildListItem(Icons.account_balance, 'Plus membership', fontSizeScaling),
                      _buildListItem(Icons.star, 'My rating', fontSizeScaling),
                      _buildListItem(Icons.location_on, 'Manage addresses', fontSizeScaling),
                      _buildListItem(Icons.credit_card, 'Manage payment methods', fontSizeScaling),
                      _buildListItem(Icons.settings, 'Settings', fontSizeScaling),
                      _buildListItem(Icons.info, 'About UC', fontSizeScaling),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SizedBox(
                    width: screenWidth * 0.8,
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
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Color(0xFFD32F2F), fontSize: 16 * fontSizeScaling),
                      ),
                    ),
                  ),
                  Spacer(),
                  // Footer
                  Text(
                    'Version 7.5.91 R455',
                    style: TextStyle(color: Colors.grey, fontSize: 12 * fontSizeScaling),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCard(IconData icon, String label, double fontSizeScaling) {
    return Container(
      padding: EdgeInsets.all(fontSizeScaling*10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1, child: Icon(icon, size: 24 * fontSizeScaling)), // Scaled icon size
          SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16 * fontSizeScaling, // Scaled text size
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildListItem(IconData icon, String label, double fontSizeScaling) {
    return ListTile(
      leading: Icon(icon, size: 24 * fontSizeScaling), // Scaled icon size
      title: Text(
        label,
        style: TextStyle(fontSize: 16 * fontSizeScaling), // Scaled font size
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16 * fontSizeScaling), // Scaled icon size
      onTap: () {},
    );
  }
}
