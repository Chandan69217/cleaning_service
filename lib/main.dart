import 'package:cleaning_service/screens/splash/splash_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/provider/booking_screen_provider.dart';
import 'package:cleaning_service/utilities/provider/cart_screen_provider.dart';
import 'package:cleaning_service/utilities/provider/home_screen_provider.dart';
import 'package:cleaning_service/utilities/provider/user_profile_provider.dart';
import 'package:cleaning_service/utilities/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Pref.instance = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider.instance,
        ),
        ChangeNotifierProvider<HomeScreenProvider>(create: (context)=> HomeScreenProvider.instance),
        ChangeNotifierProvider<CartScreenProvider>(create: (context)=> CartScreenProvider.instance),
        ChangeNotifierProvider<BookingScreenProvider>(create: (context)=> BookingScreenProvider.instance),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        home: SplashScreen(),
    );
  }
}
