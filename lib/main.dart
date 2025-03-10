import 'package:cleaning_service/screens/navigation/home_screen.dart';
import 'package:cleaning_service/screens/splash/splash_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Pref.instance = await SharedPreferences.getInstance();
  runApp(const MyApp());
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
