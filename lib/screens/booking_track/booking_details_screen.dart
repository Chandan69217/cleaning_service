import 'dart:convert';
import 'package:cleaning_service/models/global_keys.dart';
import 'package:cleaning_service/shimmer_effect/booking_details_shimmer_effect.dart';
import 'package:cleaning_service/utilities/urls/api_urls.dart';
import 'package:cleaning_service/utilities/check_internet/is_connected.dart';
import 'package:cleaning_service/utilities/check_token_validity.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/provider/booking_screen_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  BookingDetailsScreen({super.key, required this.bookingId});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();

}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  Future<Map<String,dynamic>>? bookingData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    bookingData = _getBookingDetailsById();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Booking Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: bookingData,
          builder:(context,snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return BookingDetailsShimmerEffect();
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            final bookingDetails = snapshot.data!;
            final DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm a');
            final String statusCode = bookingDetails['Sts'];
            final String statusText = _getStatusName(statusCode);
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with image and title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: bookingDetails['IconURL'] != null &&
                              bookingDetails['IconURL'].toString().isNotEmpty
                              ? NetworkImage(bookingDetails['IconURL'])
                              : const AssetImage('assets/images/service_placeholder.png')
                          as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      bookingDetails['ServiceName'] ?? 'Service',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Chip(
                                    label: Text(
                                      statusText,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: _getStatusColor(statusCode),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 24),
                    const Text(
                      'Booking Information',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),

                    _buildDetailRow(Icons.confirmation_number, 'Booking No:', bookingDetails['BookingNo']),
                    _buildDetailRow(Icons.calendar_today, 'Date:', formatter.format(DateTime.parse(bookingDetails['BookingDate']))),
                    _buildDetailRow(Icons.format_list_numbered, 'Qty:', bookingDetails['Qty'].toString()),
                    _buildDetailRow(Icons.currency_rupee, 'Price:', '₹ ${bookingDetails['Price']}'),
                    _buildDetailRow(Icons.place, 'Address:', bookingDetails['CompleteAddress']),

                    const SizedBox(height: 20),
                    const Text(
                      'Payment Summary',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),

                    _buildDetailRow(Icons.miscellaneous_services, 'Service Charge:', '₹ ${bookingDetails['ServiceCharage']}'),
                    _buildDetailRow(Icons.discount, 'Discount:', '₹ ${bookingDetails['DiscAmt']}'),
                    _buildDetailRow(Icons.receipt_long, 'Tax:', '₹ ${bookingDetails['Tax']}'),
                    _buildDetailRow(Icons.price_check, 'Net Amount:', '₹ ${bookingDetails['NetAmount']}'),

                    const SizedBox(height: 30),
                   if(!_checkIsServiceCanceled(statusCode))
                     _isLoading ? Center(child: SizedBox(width:25.0,height:25.0,child: CircularProgressIndicator())): Row(
                      children: [
                        Expanded(
                          child:OutlinedButton.icon(
                            onPressed: () {
                              _cancelBooking();
                            },
                            icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                            label: const Text('Cancel'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        if (statusCode == 'u') ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Track Booking
                              },
                              icon: const Icon(Icons.location_on_outlined,color: Colors.white,),
                              label: const Text('Track'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          SizedBox(width: 120, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value ?? '-', style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }


  Future<Map<String,dynamic>>? _getBookingDetailsById() async {
    // Check Internet Connectivity
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }

    try {
      await CheckTokenValidity.checkTokenValidity();
      var appToken = Pref.instance.getString(Consts.token);
      final url = Uri.http(Urls.base_url, Urls.getBookingDetailsById, {'appToken': appToken,'bdid':widget.bookingId});
      final response = await get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map;

        if (data.isEmpty) {
          return Future.error("Booking Details Not Available");
        }
        return data['data'];
      }else if(response.statusCode == 400){
        return Future.error("Some this went wrong !!.");
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

  Future<bool> _cancelBooking() async {
    // Check Internet Connectivity
    bool hasInternet = await CheckConnection.isConnected();
    if (!hasInternet) {
      return Future.error("No Internet Connection. Please check your network.");
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await CheckTokenValidity.checkTokenValidity();
      var appToken = Pref.instance.getString(Consts.token);
      final url = Uri.http(Urls.base_url, Urls.cancelBookingById, {'appToken': appToken,'bdid':widget.bookingId});
      final response = await get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map;

        if (data.isEmpty) {
          return Future.error("Booking Details Not Available");
        }
        final _isCancel = data['status']=='success';
        if(_isCancel){
          BookingScreenProvider.instance.getBookingList();
          bookingData = _getBookingDetailsById();
        }
        setState(() {
          _isLoading = false;
        });
        return _isCancel;
      }else {
       return false;
      }
    } catch (e) {
    print("Something went wrong. Please check your connection and try again.");
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'p':   // Pending
        return Colors.orangeAccent;
      case 'pr':  // Processing
        return Colors.blueAccent;
      case 'bc':  // Booking Completed
        return Colors.green;
      case 'c':   // Cancelled by user
        return Colors.redAccent;
      case 'r':   // Rejected by company
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusName(String status){
    switch(status.toLowerCase()){
      case 'p': return 'Pending';
      case 'pr': return 'Processing';
      case 'bc': return 'Booking Completed';
      case 'c': return 'cancel by user';
      case 'r': return 'Rejected by company';
      default: return 'unknown';
    }
  }
  bool _checkIsServiceCanceled(String status){
    switch(status.toLowerCase()){
      case 'c': return true;
      default: return false;
    }
  }
}
