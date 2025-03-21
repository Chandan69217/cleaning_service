import 'dart:convert';

import 'package:cleaning_service/models/cart_items.dart';
import 'package:cleaning_service/screens/all_service_list_screen.dart';
import 'package:cleaning_service/utilities/api_urls.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

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


class CartScreen extends StatefulWidget {
  final CartItems? cartItems;
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


  init()async{
    if(widget.cartItems != null){
      _totalAmount = _calculateTotalAmount(widget.cartItems!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.shoppingCart, color: Colors.purple[700],size: screenWidth * 0.06,),
            SizedBox(width: 10.0),
            Text("Your Cart", style: TextStyle(color: Colors.black,fontSize: screenWidth * 0.06)),
          ],
        ),
      ),
      body: !(widget.cartItems != null && widget.cartItems!.data.isNotEmpty )? _EmptyCartScreen():Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            // Cart Item
            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems!.data.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems!.data[index];
                  return _CartItemTile(
                    imageUrl: 'https://img.freepik.com/free-photo/side-view-man-working-as-plumber_23-2150746307.jpg?t=st=1740204214~exp=1740207814~hmac=d667f3b872dd3a7957fc26c458cfd2ae4f8480b378bea3ff7ce4b503eefc99c5&w=1800',
                    serviceName: item.serviceName,
                    quantity: item.qty.toInt(),
                    price: item.price.toDouble(),
                    // serviceDetails: '',
                    // serviceName:'Plumber',
                    // quantity: 3,
                    // price: 49.0,
                    serviceDetails: '${item.formatDate}',
                    onDelete: () async{
                      var status = await removeCartItem(item.id.toString());
                      if(status){
                        setState(() {
                          widget.cartItems!.data.remove(item);
                          _totalAmount = _calculateTotalAmount(widget.cartItems!);
                        });
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: screenWidth * 0.05,),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      border: Border.all(color: Colors.grey.shade300,),
                    ),
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.45,
                    child: Center(child: Text('Total: ₹${_totalAmount??0.0}')),
                  ),
                ),
                SizedBox(width: 10.0,),
                Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: screenWidth * 0.12,
                    width: screenWidth * 0.45,
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[700],
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Color(0xFF6200EE)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),

                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: screenWidth * 0.038, // Font size responsive
                          fontWeight: FontWeight.w400,
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

  double _calculateTotalAmount(CartItems cartItems){
    double totalAmount = 0;
    for(var items in cartItems.data){
      totalAmount += items.price.toDouble();
    }
    return totalAmount;
  }




  Future<bool> removeCartItem(String cartId) async {
    final String token = Pref.instance.getString(Consts.token)??'';

    try {
      final Uri uri = Uri.https(
        Urls.base_url,
        Urls.removeCartItem,
        {
          "appToken": token,
          "cartid": cartId,
        },
      );
      print(uri.toString());
      final response = await put(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return true;
        } else {
          print("Failed to remove item: ${data['message']}");
        }
      } else {
        print("Error: ${response.statusCode}, Response: ${response.reasonPhrase}");
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
                  style: TextStyle(color: Colors.grey[600], fontSize: screenWidth * 0.035),
                ),
                Text(
                  "• $serviceDetails",
                  style: TextStyle(color: Colors.grey[600], fontSize: screenWidth * 0.035),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline_outlined, color: Colors.red,),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

