import 'package:cleaning_service/screens/all_service_list_screen.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cart Image
              Image.network(
                'https://img.freepik.com/free-vector/shopping-cart-icon-isolated-illustration_18591-82226.jpg?t=st=1740292787~exp=1740296387~hmac=eafa31293c7ec9bbc6c136d7c4fe0027cec2a2d198235a714dfbd6fec2c590e7&w=1060',
                height: screenHeight * 0.2, // Adjust height relative to screen size
                width: screenWidth * 0.4, // Adjust width relative to screen size
                fit: BoxFit.cover,
              ),

              // SizedBox(height: screenHeight * 0.05),

              // Main message
              Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: screenWidth * 0.053, // Font size responsive
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.1
                ),
              ),

              // Sub message
              Text(
                'Let\'s add some services',
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Font size responsive
                  color: Color(0xFF666666),
                  height: 1.1
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Explore Button
              SizedBox(
                height: screenWidth * 0.12,
                width: screenWidth * 0.45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF6200EE),
                    side: BorderSide(color: Color(0xFF6200EE)),
                    // padding: EdgeInsets.symmetric(
                    //   vertical: screenHeight * 0.015,
                    //   horizontal: screenWidth * 0.1,
                    // ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),

                    ),
                  ),
                  child: Text(
                    'Explore Services',
                    style: TextStyle(
                      fontSize: screenWidth * 0.038, // Font size responsive
                      fontWeight: FontWeight.w400,
                    ),
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
