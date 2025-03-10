import 'package:cleaning_service/screens/authentication/login_screen.dart';
import 'package:cleaning_service/screens/navigation/home_screen.dart';
import 'package:flutter/material.dart';


class LoggedOutScreen extends StatelessWidget {
  final String title;
  final String message;
  const LoggedOutScreen({super.key, required this.title,this.message=''});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/logout.webp',
                width: screenWidth * 0.3,
                height: screenHeight * 0.15,
                fit: BoxFit.contain,
              ),

              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                message,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: (screenWidth * 0.1) * 0.2),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen(requestLogin:true,)));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
