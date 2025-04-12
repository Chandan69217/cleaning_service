import 'dart:convert';

import 'package:cleaning_service/models/data.dart';
import 'package:cleaning_service/models/shipping_address.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../widgets/cust_loader.dart';

class ManageAddressesScreen extends StatefulWidget {
  @override
  State<ManageAddressesScreen> createState() => _ManageAddressesScreenState();
}

class _ManageAddressesScreenState extends State<ManageAddressesScreen> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Addresses", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: ShippingAddressList.addresses.length,
              itemBuilder: (context, index) {
                final address = ShippingAddressList.addresses[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(address.mobile, style: TextStyle(color: Colors.grey[700])),
                        SizedBox(height: 8),
                        Text('${address.address}, ${address.landMark}, ${address.city}, ${address.state}, ${address.country}- ${address.pincode}', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
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
                                  builder: (context) => AddAddress(
                                    address: address,
                                    onSave: (address) {
                                      setState(() {
                                      });
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, size: 18),
                              label: Text("Edit"),
                            ),
                            SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.delete_outline, size: 18, color: Colors.red),
                              label: Text("Delete", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Add Address Button
          SafeArea(
            minimum: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
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
                    builder: (context) => AddAddress(
                      onSave: (address) {
                        setState(() {
                        });
                      },
                    ),
                  );
                },
                icon: Icon(Icons.add_location_alt_outlined,color: Colors.white,),
                label: Text("Add New Address", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class AddAddress extends StatefulWidget {
  final Function(String) onSave;
  final ShippingAddress? address;

  const AddAddress({super.key, required this.onSave,this.address});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final List<TextEditingController> _controllers = List.generate(
    9,
        (index) => TextEditingController(),
  );
  String name = '', phone = '', email = '', street = '', address = '',
      state = '', city = '', pincode = '', country = 'India';


  @override
  void initState() {
    super.initState();
    if(widget.address!= null){
      _controllers[0].text = widget.address!.name;
      _controllers[1].text = widget.address!.mobile;
      _controllers[2].text = widget.address!.email;
      _controllers[3].text = widget.address!.address;
      _controllers[4].text = widget.address!.landMark;
      _controllers[5].text = widget.address!.city;
      _controllers[6].text = widget.address!.state;
      _controllers[7].text = widget.address!.country;
      _controllers[8].text = widget.address!.pincode;
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 80.0),
        Padding(
          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            icon: Icon(Icons.close_rounded),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.05),
              topRight: Radius.circular(screenWidth * 0.05),
            ),
            child: Container(
              color: Colors.white,
              width: screenWidth,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.address != null ? "Update Your Address":"Add New Address",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 24.0,),
                            _textField("Name", (val) => name = val,controller: _controllers[0]),
                            _textField("Mobile Number", (val) => phone = val,
                                keyboard: TextInputType.phone,controller: _controllers[1]),
                            _textField("Email Address", (val) => email = val,
                                keyboard: TextInputType.emailAddress,controller: _controllers[2]),
                            _textField("Address", (val) => address = val,controller: _controllers[3]),
                            _textField("Street / Landmark", (val) => street = val,controller: _controllers[4]),
                            _textField("City", (val) => city = val,controller: _controllers[5]),
                            _textField("State", (val) => state = val,controller: _controllers[6]),
                            // _textField("Country", (val) => country = val,controller: _controllers[7]),
                            _textField("Pincode", (val) => pincode = val,
                                keyboard: TextInputType.number,controller: _controllers[8]),
                            const SizedBox(height: 16),
                            _isLoading
                                ? CustLoader()
                                : ElevatedButton(
                              onPressed: widget.address != null ? (){}:_saveAddress,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[700],
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(widget.address != null ?"Update Address": "Save Address",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
  }
  Widget _textField(String hint, Function(String) onChanged,
      {TextInputType keyboard = TextInputType.text,TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
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
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      var appToken = Pref.instance.getString(Consts.token);
      var uri = Uri.https(Urls.base_url, Urls.addShippingAddress, {'appToken': appToken});
      var body = jsonEncode({
        "Name": name,
        "Mobile": phone,
        "Email": email,
        "Address": address,
        "LandMark": street,
        "City": city,
        "State": state,
        "Country": country,
        "Pincode": pincode,
        "Latitude": "${Data.user_position!.latitude}",
        "Longitude": "${Data.user_position!.longitude}"
      });

      var response = await post(uri, body: body, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        String formattedAddress =
            "$name, $phone\n$address, $street, $city, $state, $country - $pincode";
        widget.onSave(formattedAddress);
        ShippingAddressList.isInitialized = false;
        if(await ShippingAddressList.fetchAddresses())
        Navigator.pop(context);
      } else {
        print('Server error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error saving address: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }
}