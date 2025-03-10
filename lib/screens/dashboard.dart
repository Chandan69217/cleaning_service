import 'package:cleaning_service/screens/authentication/logged_out_screen.dart';
import 'package:cleaning_service/screens/navigation/account_screen.dart';
import 'package:cleaning_service/screens/navigation/bookings_screen.dart';
import 'package:cleaning_service/screens/navigation/home_screen.dart';
import 'package:cleaning_service/screens/navigation/reward_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget{
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  late bool _isLoggedIn;
  final List<Widget> _screens = [LoggedInHomeScreen(),BookingsScreen(),RewardsScreen(),AccountScreen()];
  final List<Widget> _skippedScreens = [SkipeedHomeScreen(),LoggedOutScreen(title: 'Whoops, You are not logged in yet!',message: 'Please login to check booking information',),LoggedOutScreen(title: 'Whoops, You are not logged in yet!',message: 'Please login to check your reward information',),SkippedAccountScreen(),];
  @override
  void initState() {
    super.initState();
    _isLoggedIn = Pref.instance.getBool(Consts.isLogin)??false;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top,SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.03;
    double iconSize = screenWidth * 0.045;
    return Scaffold(
      backgroundColor:Color(0xFFF9F9F9),
      body: SafeArea(
        child: _isLoggedIn ? _screens[_currentIndex] : _skippedScreens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: CustColors.primary,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: fontSize,
          unselectedFontSize: fontSize,
          selectedItemColor:CustColors.white,
          unselectedItemColor: Colors.grey,
          iconSize: iconSize,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          // unselectedItemColor: ColorTheme.Gray,
          onTap: (selectedIndex){
            setState(() {
              _currentIndex = selectedIndex;
            });
          },
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),activeIcon: Icon(FontAwesomeIcons.home,),
              label: 'Home',),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCalendarCheck),activeIcon:Icon(FontAwesomeIcons.solidCalendarCheck),
                label: 'Bookings'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.wallet),activeIcon: Icon(FontAwesomeIcons.wallet),
                label: 'Rewards'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCircleUser),activeIcon: Icon(FontAwesomeIcons.solidCircleUser),
                label: 'Account'),
          ]),
    );
  }
}


