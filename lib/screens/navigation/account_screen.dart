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
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Text(
                mobileNo != null ? '+91 $mobileNo' : 'N/A',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black,size: screenWidth * 0.052,),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(screenWidth * 0.05,),
              child: GridView.count(
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: screenWidth * 0.02,
                mainAxisSpacing: screenHeight * 0.02,
                children: [
                  _buildCard(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingsScreen()));
                  },Icons.content_paste, 'My bookings',screenWidth),
                  _buildCard(Icons.devices, 'Native devices',screenWidth),
                  _buildCard(Icons.headset, 'Help & support',screenWidth),
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
                      _buildListItem(Icons.description, 'My Plans',screenWidth),
                      _buildListItem(Icons.account_balance_wallet, 'Wallet',screenWidth),
                      _buildListItem(Icons.account_balance, 'Plus membership',screenWidth),
                      _buildListItem(Icons.star, 'My rating',screenWidth),
                      _buildListItem(Icons.location_on, 'Manage addresses',screenWidth),
                      _buildListItem(Icons.credit_card, 'Manage payment methods',screenWidth),
                      _buildListItem(Icons.settings, 'Settings',screenWidth),
                      _buildListItem(Icons.info, 'About UC',screenWidth),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SizedBox(
                    width: double.infinity,
                    height: screenWidth * 0.11,
                    child: ElevatedButton(
                      onPressed: () {
                        Pref.instance.clear();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()),(route)=> false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFFD32F2F),
                        side: BorderSide(color: Color(0xFFD32F2F)),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Color(0xFFD32F2F), fontSize: (screenWidth * 0.11)*0.4),
                        ),
                      ),
                    ),
                  ),
                  // Footer
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Version 7.5.91 R455',
                    style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.033),
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


  Widget _buildCard(IconData icon, String label,double screenWidth,{VoidCallback? onTap,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 1, child: FittedBox(fit:BoxFit.contain,child: Icon(icon, size: 20 ))),
            SizedBox(height: 20.0),
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildListItem(IconData icon, String label,double screenWidth) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: screenWidth * 0.06 ), // Scaled icon size
      title: Text(
        label,
        style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.normal), // Scaled font size
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04), // Scaled icon size
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

