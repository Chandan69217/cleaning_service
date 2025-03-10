import 'package:cleaning_service/screens/authentication/login_screen.dart';
import 'package:cleaning_service/screens/navigation/bookings_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? mobileNo;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async{
    mobileNo = Pref.instance.getString(Consts.mobileNo);
  }


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
                mobileNo != null ? '+91 $mobileNo' : 'N/A',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: GridView.count(
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: screenWidth * 0.02,
                mainAxisSpacing: screenHeight * 0.02,
                children: [
                  _buildCard(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingsScreen()));
                  },Icons.content_paste, 'My bookings', fontSizeScaling),
                  _buildCard(Icons.devices, 'Native devices', fontSizeScaling),
                  _buildCard(Icons.headset, 'Help & support', fontSizeScaling),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              child: Column(
                children: [
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
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
                      onPressed: () {
                        Pref.instance.clear();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()),(route)=> false);
                      },
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
                  // Footer
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Version 7.5.91 R455',
                    style: TextStyle(color: Colors.grey, fontSize: 12 * fontSizeScaling),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCard(IconData icon, String label, double fontSizeScaling,{VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(fontSizeScaling*10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: Icon(icon, size: 20 * fontSizeScaling)),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14 * fontSizeScaling,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildListItem(IconData icon, String label, double fontSizeScaling) {
    return ListTile(
      leading: Icon(icon, size: 16 * fontSizeScaling), // Scaled icon size
      title: Text(
        label,
        style: TextStyle(fontSize: 14 * fontSizeScaling,fontWeight: FontWeight.normal), // Scaled font size
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 14 * fontSizeScaling,), // Scaled icon size
      onTap: () {},
    );
  }

}







class SkippedAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ Text(
              'Profile',
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6200EE),
                textStyle: TextStyle(fontSize: screenWidth * 0.02),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen(requestLogin: true,)));
              },
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
            ),
              ]),
          ),
          SizedBox(height: screenHeight * 0.008),

          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.01),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
            leading: Icon(
              FontAwesomeIcons.circleInfo,
              size: screenWidth * 0.07,
              // width: screenWidth * 0.08,
              // height: screenWidth * 0.08,
            ),
            title: Text(
              'About Cleaning Service',
              style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.black87),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey[500]),
            onTap: () {
              // Navigate to About UC screen
            },
                      ),),
          SizedBox(height: screenHeight * 0.008),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenHeight * 0.01),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'Version 7.5.92 R457',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.001),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

