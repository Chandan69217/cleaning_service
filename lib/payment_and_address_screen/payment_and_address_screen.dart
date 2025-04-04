import 'dart:convert';
import 'dart:io';
import 'package:cleaning_service/models/data.dart';
import 'package:cleaning_service/models/shipping_address.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/widgets/cust_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import '../testing.dart';
import '../utilities/api_urls.dart';

class PaymentAndAddressScreen extends StatefulWidget {
  final String? id;
  const PaymentAndAddressScreen({super.key, this.id});

  @override
  State<PaymentAndAddressScreen> createState() => _PaymentAndAddressScreenState();
}

class _PaymentAndAddressScreenState extends State<PaymentAndAddressScreen> {
  String selectedPayment = 'UPI';
  bool isProcessing = false;
  String fullAddress = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Confirm & Pay', style: TextStyle(color: Colors.black)),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            elevation: 1,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Your Address"),
                _addressCard(widget.id.toString()),
                const SizedBox(height: 24),

                _sectionTitle("Payment Method"),
                _paymentOption("UPI", Icons.account_balance_wallet),
                _paymentOption("Cash on Service", Icons.money),
                _paymentOption("Wallet", Icons.account_balance),

                const SizedBox(height: 24),

                _sectionTitle("Price Summary"),
                _priceRow("Subtotal", "₹899"),
                const SizedBox(height: 8),
                _priceRow("Taxes & Fees", "₹99"),
                const Divider(thickness: 1),
                _priceRow("Total", "₹998", isTotal: true),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _onConfirmAndPay,
                    child: const Text('Confirm & Pay',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isProcessing) _paymentProcessingOverlay(),
      ],
    );
  }

  Widget _paymentProcessingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Lottie.asset(
          'assets/payment_success.json',
          width: 200,
          height: 200,
          repeat: false,
          onLoaded: (composition) async {
            await Future.delayed(const Duration(seconds: 2));
            setState(() => isProcessing = false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutSuccessScreen()),
            );
          },
        ),
      ),
    );
  }

  void _onConfirmAndPay() {
    if (fullAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select or enter an address")),
      );
      return;
    }
    setState(() => isProcessing = true);
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _addressCard(String id) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.home, color: Colors.purple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Home Address",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(
                    fullAddress.isEmpty ? "No address selected" : fullAddress,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  useSafeArea: true,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => AddressBottomSheet(
                    onSave: (address) {
                      setState(() {
                        fullAddress = address;
                      });
                    },
                  ),
                );
              },
              child: const Text("Change", style: TextStyle(color: Colors.purple)),
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String title, IconData icon) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: RadioListTile(
        value: title,
        groupValue: selectedPayment,
        onChanged: (val) {
          setState(() {
            selectedPayment = val.toString();
          });
        },
        title: Text(title),
        secondary: Icon(icon, color: Colors.purple),
        activeColor: Colors.purple,
      ),
    );
  }

  Widget _priceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
          Text(amount,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              )),
        ],
      ),
    );
  }
}

class AddressBottomSheet extends StatefulWidget {
  final Function(String) onSave;

  const AddressBottomSheet({super.key, required this.onSave});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String name = '', phone = '',email = '',street = '', address = '', state = '', city = '', pincode = '',country = '';

  final List<String> staticAddresses = ShippingAddressList.addresses
      .map((address) => address.getCompleteDetails())
      .toList();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
    mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 80.0,),
        Padding(
          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              style: IconButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              icon: Icon(
                Icons.close_rounded,
              )),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.05),
                topRight: Radius.circular(screenWidth * 0.05)),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Choose from Saved Addresses",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      ...staticAddresses.map((address) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.location_on, color: Colors.purple),
                          title: Text(address),
                          onTap: () {
                            widget.onSave(address);
                            Navigator.pop(context);
                          },
                        ),
                      )),
                      const Divider(height: 24),
                      const Text("Or Add New Address",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      _textField("Name", (val) => name = val),
                      _textField("Mobile Number", (val) => phone = val, keyboard: TextInputType.phone),
                      _textField("Email Address", (val) => email = val, keyboard: TextInputType.emailAddress),
                      _textField("Address", (val) => address = val),
                      _textField("Street / Landmark", (val) => street = val),
                      _textField("City", (val) => city = val),
                      _textField("State", (val) => state = val),
                      _textField("Country", (val) => country = val),
                      _textField("Pincode", (val) => pincode = val, keyboard: TextInputType.number),
                      const SizedBox(height: 16),
                      _isLoading ? CustLoader():ElevatedButton(
                        onPressed: _saveAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[700],
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Save Address", style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(String hint, Function(String) onChanged,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (val) => val == null || val.isEmpty ? 'Required' : null,
        onChanged: onChanged,
      ),
    );
  }

  void _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
     return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      var appToken = Pref.instance.getString(Consts.token);
      var uri = Uri.https(Urls.base_url, Urls.addShippingAddress,{'appToken':appToken});
      var body = jsonEncode({
          "Name": "$name",
          "Mobile": "$phone",
          "Email": "$email",
          "Address": "$address",
          "LandMark": "$street",
          "City": "$city",
          "State": "$state",
          "Country": "$country",
          "Pincode": "$pincode",
          "Latitude": "${Data.user_position!.latitude}",
          "Longitude": "${Data.user_position!.longitude}"
        });
      var response = await post(uri,body: body ,headers: {
        'Content-Type': 'application/json',
      });
      print(response.body);
      if (response.statusCode == 200) {
        String formattedAddress = "$name, $phone\n$address, $street, $city, $state, $country - $pincode";
        widget.onSave(formattedAddress);
        ShippingAddressList.isInitialized = false;
        ShippingAddressList.fetchAddresses();
        Navigator.pop(context);
      } else {
        print('Server error: ${response.statusCode} - ${response.reasonPhrase}');
        return ;
      }
    } on SocketException catch (e) {
      print('No internet connection: $e');
    } on HttpException catch (e) {
      print('HTTP Exception: $e');
    } on FormatException catch (e) {
      print('Bad response format: $e');
    } catch (e) {
      print('Unexpected error: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }
}
