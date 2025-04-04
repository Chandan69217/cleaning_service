import 'dart:convert';

import 'package:cleaning_service/models/booked_service_list.dart';
import 'package:cleaning_service/screens/service_options.dart';
import 'package:cleaning_service/shimmer_effect/category_effect/booking_shimmer_effect.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/widgets/cust_loader.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../booking_track/TrackBookingScreen.dart';

class BookingsScreen extends StatefulWidget {
  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  // final List<Map<String, dynamic>> bookings = [
  //   {
  //     'service': 'Home Cleaning',
  //     'date': 'March 25, 2025 - 2:00 PM',
  //     'status': 'Upcoming',
  //     'image': 'assets/pictures/book_a_visit.webp',
  //   },
  //   {
  //     'service': 'Salon at Home',
  //     'date': 'March 22, 2025 - 11:00 AM',
  //     'status': 'Completed',
  //     'image': 'assets/pictures/book_a_visit.webp',
  //   },
  //   {
  //     'service': 'AC Repair',
  //     'date': 'March 20, 2025 - 4:00 PM',
  //     'status': 'Cancelled',
  //     'image': 'assets/pictures/book_a_visit.webp',
  //   },
  // ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: FutureBuilder<BookedServiceList?>(
        future: _getBookingList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BookingShimmerEffect();
          }
          if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data == null||snapshot.data!.bookingsList.isEmpty) {
            return _buildEmptyState();
          }

          var bookings = snapshot.data!.bookingsList;


          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return Container(
                margin: index == 0 ? EdgeInsets.zero:EdgeInsets.only(top: 2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2.0,
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            booking.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.serviceName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Qty: ${booking.qty} | ₹${booking.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              booking.formatDate ?? 'No Date Available',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              booking.status,
                              // booking.status ?? 'Unknown Status',
                              style: TextStyle(
                                color: _getStatusColor(booking.status),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (booking.status == 'upcoming')
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrackBookingScreen(
                                  service: booking.serviceName,
                                  professionalName: 'Amit Sharma',
                                  status: 'Professional is on the way',
                                  eta: '15 mins',
                                  profileImage: 'assets/pictures/book_a_visit.webp',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text('Track'),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }



  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Oops! Something went wrong.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: (){
                setState(() {

                });
              }, // Calls the retry function
              icon: Icon(Icons.refresh),
              label: Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              "No Bookings Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "You haven't booked any services yet. Book now to see them here.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: (){
                showServicesOptions(context,);
              }, // Calls the retry function
              icon: Icon(Icons.add),
              label: Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<BookedServiceList?> _getBookingList() async {
    // Check Internet Connectivity
    bool hasInternet = await isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }

    try {
      var appToken = Pref.instance.getString(Consts.token);
      final url = Uri.http(Urls.base_url, Urls.getBookingList, {'appToken': appToken});
      final response = await get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data == null || data.isEmpty) {
          return Future.error("No booking data found.");
        }

        return BookedServiceList.fromJson(data);
      }else if(response.statusCode == 400){
        return Future.error("No booking data found.");
      }
      else if (response.statusCode == 401) {
        return Future.error("Session expired. Please log in again.");
      }
      else if (response.statusCode == 403) {
        return Future.error("Access denied. You do not have permission.");
      }
      else if (response.statusCode == 404) {
        return Future.error("Booking service not found.");
      }
      else if (response.statusCode == 500) {
        return Future.error("Server error. Please try again later.");
      }
      else {
        return Future.error("Unexpected error: ${response.statusCode}. Please try again.");
      }
    } catch (e) {
      return Future.error("Something went wrong. Please check your connection and try again.");
    }
  }


  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     appBar: AppBar(
//       backgroundColor: Colors.white,
//       title: const Text('My Bookings'),
//       centerTitle: true,
//     ),
//     body: FutureBuilder<BookedServiceList?>(
//       future: _getBookingList(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CustLoader();
//         }
//
//         if (snapshot.hasError) {
//           return _buildErrorWidget(snapshot.error.toString());
//         }
//
//         if (!snapshot.hasData || snapshot.data == null) {
//           return _buildEmptyState();
//         }
//
//         var bookings = snapshot.data!.bookingsList;
//
//         return ListView.builder(
//           itemCount: bookings.length,
//           itemBuilder: (context, index) {
//             final booking = bookings[index];
//
//             return Card(
//               color: Colors.white,
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 60,
//                       width: 60,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset(
//                           booking.image ?? 'assets/default_image.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             booking.serviceName,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Qty: ${booking.qty} | ₹${booking.price}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             booking.formatDate ?? 'No Date Available',
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Unknown Status, Data not provided in api',
//                             // booking.status ?? 'Unknown Status',
//                             style: TextStyle(
//                               color: _getStatusColor('Upcoming'),
//                               // color: _getStatusColor(booking.status),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // if (booking.status == 'Upcoming')
//                     //   ElevatedButton(
//                     //     onPressed: () {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => TrackBookingScreen(
//                     //             service: booking.service ?? 'Unknown',
//                     //             professionalName: 'Amit Sharma',
//                     //             status: 'Professional is on the way',
//                     //             eta: '15 mins',
//                     //             profileImage: 'assets/pictures/book_a_visit.webp',
//                     //           ),
//                     //         ),
//                     //       );
//                     //     },
//                     //     style: ElevatedButton.styleFrom(
//                     //       backgroundColor: Colors.blue,
//                     //       foregroundColor: Colors.white,
//                     //       shape: RoundedRectangleBorder(
//                     //         borderRadius: BorderRadius.circular(12),
//                     //       ),
//                     //       padding: const EdgeInsets.symmetric(
//                     //         horizontal: 16,
//                     //         vertical: 8,
//                     //       ),
//                     //       textStyle: const TextStyle(fontSize: 12),
//                     //     ),
//                     //     child: const Text('Track'),
//                     //   ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     ),
//   );
// }