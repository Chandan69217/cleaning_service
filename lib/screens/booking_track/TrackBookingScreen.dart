import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackBookingScreen extends StatefulWidget {
  final String service;
  final String professionalName;
  final String status;
  final String eta; // Estimated Time of Arrival
  final String profileImage;

  const TrackBookingScreen({
    super.key,
    required this.service,
    required this.professionalName,
    required this.status,
    required this.eta,
    required this.profileImage,
  });

  @override
  State<TrackBookingScreen> createState() => _TrackBookingScreenState();
}

class _TrackBookingScreenState extends State<TrackBookingScreen> {
  late GoogleMapController mapController;

  final LatLng _userLocation = LatLng(28.6139, 77.2090); // Example: Delhi
  final LatLng _professionalLocation = LatLng(28.6200, 77.2100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track ${widget.service}'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // MAP PLACEHOLDER
          Container(
            height: 220,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(
                Icons.map_outlined,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // STATUS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.status,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // PROFESSIONAL INFO CARD
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      widget.profileImage,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.professionalName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Estimated Arrival: ${widget.eta}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.phone, color: Colors.blue),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                // Cancel logic or other options
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel Booking'),
            ),
          )
        ],
      ),
    );
  }
}
