import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Network Image
            // Positioned.fill(
            //   child: Image.network(
            //     'https://images.pexels.com/photos/414214/pexels-photo-414214.jpeg', // Replace with your image URL
            //     fit: BoxFit.cover, // Ensures the image covers the whole screen
            //     loadingBuilder: (context, child, loadingProgress) {
            //       if (loadingProgress == null) {
            //         return child;
            //       } else {
            //         return Center(
            //           child: CircularProgressIndicator(
            //             value: loadingProgress.expectedTotalBytes != null
            //                 ? loadingProgress.cumulativeBytesLoaded /
            //                 (loadingProgress.expectedTotalBytes ?? 1)
            //                 : null,
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),

            // Your existing content
            Column(
              children: [
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustColors.primary,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          width: 48,
                          height: 48,
                          child: Center(
                            child: Text(
                              'CS',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Company text
                        RichText(
                          text: TextSpan(
                              text: 'Cleaning',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '\nService',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                    Text('Your Home Service Expert',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black)),
                    Text('Quick • Affordable • Trusted',
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(height: 40),

                    // Mobile Number Input Container
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                            ),
                            child: Center(
                              child: Icon(Icons.phone_android_outlined),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Enter Mobile Number',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.0),

                    // Button to get verification code
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Get Verification Code'),
                      ),
                    ),
                  ],
                ),
                // Skip button
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    height: 35.0,
                    width: 65.0,
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Skip',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          overlayColor: Colors.transparent,
                          backgroundColor: Colors.black.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
