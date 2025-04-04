import 'dart:convert';

import 'package:cleaning_service/models/cart_items.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../payment_and_address_screen/payment_and_address_screen.dart';


class _EmptyCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                height:
                    screenHeight * 0.2, // Adjust height relative to screen size
                width:
                    screenWidth * 0.4, // Adjust width relative to screen size
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
                    height: 1.1),
              ),

              // Sub message
              Text(
                'Let\'s add some services',
                style: TextStyle(
                    fontSize: screenWidth * 0.05, // Font size responsive
                    color: Color(0xFF666666),
                    height: 1.1),
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


class CartScreen extends StatefulWidget {
  final CartItemsList? cartItems;
  CartScreen({this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double? _totalAmount;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.cartItems != null) {
      _totalAmount = _calculateTotalAmount(widget.cartItems!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: BackButton(color: Colors.black),
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.05,
          ),
        ),
      ),
      body: !(widget.cartItems != null && widget.cartItems!.data.isNotEmpty)
          ? Center(child: Text("Your cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: widget.cartItems!.data.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems!.data[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://img.freepik.com/free-photo/side-view-man-working-as-plumber_23-2150746307.jpg?t=st=1740204214~exp=1740207814~hmac=d667f3b872dd3a7957fc26c458cfd2ae4f8480b378bea3ff7ce4b503eefc99c5&w=1800',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item.serviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        Text(
                          item.formatDate ?? '',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Qty: ${item.qty} | ₹${item.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () async {
                        var status = await removeCartItem(item.id.toString());
                        if (status) {
                          setState(() {
                            widget.cartItems!.data.remove(item);
                            _totalAmount = _calculateTotalAmount(widget.cartItems!);
                          });
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _priceRow('Subtotal', '₹${_totalAmount?.toStringAsFixed(2) ?? "0.00"}'),
                _priceRow('Tax (18%)', '₹0'),
                const Divider(),
                _priceRow(
                  'Total',
                  '₹${_totalAmount?.toStringAsFixed(2) ?? "0.00"}',
                  isBold: true,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  PaymentAndAddressScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Proceed to Checkout'),
                ),
              ],
            ),
          ),

        ],
      ),
    );

  }
  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  double _calculateTotalAmount(CartItemsList cartItems) {
    double totalAmount = 0;
    for (var item in cartItems.data) {
      totalAmount += item.price.toDouble();
    }
    return totalAmount;
  }

  Future<bool> removeCartItem(String cartId) async {
    final String token = Pref.instance.getString(Consts.token) ?? '';

    try {
      final Uri uri = Uri.https(
        Urls.base_url,
        Urls.removeCartItem,
        {
          "appToken": token,
          "cartid": cartId,
        },
      );
      final response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'success';
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
    return false;
  }
}




class _CartItemTile extends StatelessWidget {
  final String imageUrl;
  final String serviceName;
  final int quantity;
  final double price;
  final String serviceDetails;
  final VoidCallback onDelete;

  const _CartItemTile({
    Key? key,
    required this.imageUrl,
    required this.serviceName,
    required this.quantity,
    required this.price,
    required this.serviceDetails,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Qty $quantity • ₹$price",
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: screenWidth * 0.035),
                ),
                Text(
                  "• $serviceDetails",
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: screenWidth * 0.035),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
