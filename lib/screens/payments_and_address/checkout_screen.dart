import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Booking Confirmed',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/success_animation.json', // Add your animation file here
              width: screenWidth * 0.5,
              repeat: false,
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your booking has been successfully confirmed.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Booking Summary Card
            // Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   elevation: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 20.0, horizontal: 16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         _BookingRow(label: 'Service', value: 'Salon at Home'),
            //         SizedBox(height: 10),
            //         _BookingRow(label: 'Date', value: 'March 26, 2025'),
            //         SizedBox(height: 10),
            //         Divider(thickness: 1),
            //         SizedBox(height: 10),
            //         _BookingRow(label: 'Total Amount', value: '₹998'),
            //       ],
            //     ),
            //   ),
            // ),
            // const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(screenWidth, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Go to Home',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _BookingRow extends StatelessWidget {
  final String label;
  final String value;
  const _BookingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        Text(value, style: const TextStyle(fontSize: 15)),
      ],
    );
  }
}
