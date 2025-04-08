import 'package:cleaning_service/screens/dashboard.dart';
import 'package:cleaning_service/screens/navigation/bookings_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/navigation/home_screen.dart';

class Keys{
  static final homeScreenKey = GlobalKey<LoggedInHomeScreenState>();
  static final bookingScreenKey = GlobalKey<BookingsScreenState>();
  static final dashboardScreenKey = GlobalKey<DashboardState>();
}