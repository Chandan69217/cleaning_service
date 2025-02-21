import 'package:flutter/material.dart';


class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSizeScaling = screenWidth / 375;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'My Bookings',
          style: TextTheme.of(context).bodyLarge
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Help',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF6A0DAD),
                fontSize: 16 * fontSizeScaling,)
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No bookings yet.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18*fontSizeScaling)
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive height
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Looks like you haven’t experienced quality services at home.',
                  style: TextStyle(
                    fontSize: 14 * fontSizeScaling,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Explore our services →',
                  style: TextStyle(
                    fontSize: 16 * fontSizeScaling,
                    color: Color(0xFF6A0DAD),
                    decoration: TextDecoration.underline,
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
