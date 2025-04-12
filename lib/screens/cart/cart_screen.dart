import 'package:cleaning_service/models/cart_items.dart';
import 'package:cleaning_service/models/categories_service.dart';
import 'package:cleaning_service/models/global_keys.dart';
import 'package:cleaning_service/utilities/provider/cart_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../payments_and_address/payment_and_address_screen.dart';
import '../../widgets/counter_button.dart';


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
              Image.asset(
                'assets/icons/shopping_cart.webp',
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
  CartScreen();

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  // List<CartItems> _cartItems = [];
  Set<int> _deletingItemIds = {};

  @override
  void initState() {
    super.initState();
  }

  // init() async {
  //   if (CartItemsList.globalCartItems.isNotEmpty) {
  //     _totalAmount = _calculateTotalAmount(CartItemsList.globalCartItems);
  //   }
  // }

  // init() async {
  //   _cartItems = List.from(CartItemsList.globalCartItems);
  //   if (_cartItems.isNotEmpty) {
  //     _totalAmount = _calculateTotalAmount(_cartItems);
  //   }
  //   WidgetsBinding.instance.addPostFrameCallback((duration){
  //     setState(() {});
  //   });
  // }


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
      body: FutureBuilder(future: CartScreenProvider.instance.getCartItems(), builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if(snapshot.hasError){
          return Center(child:  Text(snapshot.error.toString()),);
        }

        return Consumer<CartScreenProvider>(builder: (context,value,child){
          var cartItem = value.cartItemsList.data;
          return (cartItem.isEmpty)
              ?_EmptyCartScreen()
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  itemCount: cartItem.length,
                  itemBuilder: (context, index) {
                    final item = cartItem[index];
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
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> _CartItemDetailsScreen(cartItems: item,)));
                        },
                        contentPadding: EdgeInsets.all(15),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:  FadeInImage.assetNetwork(
                            height: 60.0,
                            width: 60.0,
                            placeholder: 'assets/icons/image_placeholder.webp', // Your asset placeholder image
                            image: item.image,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/icons/image_placeholder.webp', // Your fallback asset image
                                fit: BoxFit.cover,
                                height: 60.0,
                                width: 60.0,
                              );
                            },
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
                        trailing: _deletingItemIds.contains(item.id) ? SizedBox(width:25.0, height: 25.0,child: CircularProgressIndicator(color: Colors.indigoAccent,)): IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () async {
                            setState(() {
                              _deletingItemIds.add(item.id.toInt());
                            });
                            var status = await CartScreenProvider.instance.removeCartItem(item.id.toString());
                            setState(() {
                              _deletingItemIds.remove(item.id.toInt());
                            });
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
                    _priceRow('Subtotal', '₹${value.totalAmount.toStringAsFixed(2) ?? "0.00"}'),
                    _priceRow('Tax (18%)', '₹0'),
                    const Divider(),
                    _priceRow(
                      'Total',
                      '₹${value.totalAmount.toStringAsFixed(2) ?? "0.00"}',
                      isBold: true,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PaymentAndAddressScreen(subTotal: value.totalAmount)),
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
          );
        });
      })
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



}


class _CartItemDetailsScreen extends StatefulWidget{
  final CartItems cartItems;
  Service? service;
  _CartItemDetailsScreen({required this.cartItems}){
    service = CategoriesServiceModel.getServiceById(cartItems.serviceId.toInt());
  }

  @override
  State<_CartItemDetailsScreen> createState() => _CartItemDetailsScreenState();
}

class _CartItemDetailsScreenState extends State<_CartItemDetailsScreen> {
  bool _isAdd = false;
  int _itemQuantity = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async{
    WidgetsBinding.instance.addPostFrameCallback((duraction){
      setState(() {
        _itemQuantity = CartItemsList.itemQty[widget.service!.id]??0;
        if(_itemQuantity > 0 ){
          _isAdd = true;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddProductUI(context),
              SizedBox(height: screenHeight * 0.01,),
              _buildShareUI(context),
              // _buildFQAUI(context),
              // _buildReviewSlider(context),
              // _buildReviewList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddProductUI(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          FadeInImage.assetNetwork(
            height: screenHeight * 0.3,
            width: screenWidth,
            placeholder: 'assets/icons/image_placeholder.webp', // Your asset placeholder image
            image: widget.service!.thumbnailUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/icons/image_placeholder.webp', // Your fallback asset image
                fit: BoxFit.cover,
                height: screenHeight * 0.3,
                width: screenWidth,
              );
            },
          ),
          SizedBox(height: screenHeight * 0.03),
          // Product details
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Info Section
                      Text(
                        widget.service != null ? widget.service!.serviceName : 'N/A',
                        style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            height: 1.1),
                      ),
                      SizedBox(height: screenWidth * 0.008),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: screenWidth * 0.045,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            '4.80 (88K reviews)',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: screenWidth * 0.04,
                                height: 1.1),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.009),
                      Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenWidth * 0.043,
                                  fontWeight: FontWeight.w600,
                                  height: 1.1,
                                  color: Colors.black, // Always set color in RichText
                                ),
                                children: [
                                  TextSpan(
                                    text: '₹',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.042,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.service != null
                                        ? '${widget.service!.price}'
                                        : '0.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(text: '  '),
                                  if(_hasDiscount(price: widget.service!.price, strikePrice: widget.service!.strikePrice))TextSpan(
                                    text: widget.service != null
                                        ? '₹${widget.service!.strikePrice}'
                                        : '₹0.00',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.038,
                                      decoration: TextDecoration.lineThrough,
                                      height: 1.2,
                                      decorationThickness: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            '• ${widget.service!.duration.toInt()} mins',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: screenWidth * 0.042,
                                height: 1.1),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.009),
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer_rounded,
                            color: Colors.green,
                            size: screenWidth * 0.045,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          if(_hasDiscount(price: widget.service!.price, strikePrice: widget.service!.strikePrice))
                            Text(
                              '${_calculateDiscount(price: widget.service!.price, strikePrice: widget.service!.strikePrice)} off',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: screenWidth * 0.04,
                                  height: 1.1),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Add Button
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child:  _isAdd?Align(
                    alignment: Alignment.centerRight,
                    child: CounterButton(service: widget.service!,
                      initialValue: _itemQuantity,
                      onChanged: (newValue)async{
                        setState(() {
                          if(newValue < 1){
                            _isAdd = false;
                            _itemQuantity = 0;
                          }else{
                            _itemQuantity = newValue;
                          }
                        });
                      },
                    ),
                  ):Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: screenWidth * 0.09,
                      width: screenWidth * 0.22,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black12, width: 0.5),
                          foregroundColor: Colors.black,
                          elevation: 1,
                          overlayColor: Colors.black12,
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.015),
                          ),
                        ),
                        onPressed: _isLoading ? null:() async {
                          _itemQuantity = 1;
                          setState(() {
                            _isLoading = true;
                          });
                          _isAdd = await CartScreenProvider.instance.addToCart(
                            context: context,
                            serviceId: widget.service!.id,
                            qty: _itemQuantity,
                            price: widget.service!.price.toDouble(),
                          );
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: (screenWidth * 0.09) * 0.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            if(_isLoading)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: LinearProgressIndicator(
                                  minHeight: 2,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenWidth * 0.05,
          ),
          _buildExtraProductDetailsUI(
            context,
            'Included',
            [
              'Repair of flush leakage or low water flow suited for old or damaged flush tank',
              'Replacement of faulty flush button',
              'Procurement of flush button (at extra cost)',
            ],
            Icons.check_circle,
          ),
          SizedBox(height: screenHeight * 0.03),
          // Please note Section
          _buildExtraProductDetailsUI(
            context,
            'Please note',
            [
              'Flush tank replacement is not included',
              'Major masonry work like tiling/cementing/granite installation is not included',
            ],
            Icons.info,
            infoIcon: true,
          ),
          SizedBox(
            height: screenWidth * 0.05,
          ),
        ],
      ),
    );
  }

  Widget _buildExtraProductDetailsUI(
      BuildContext context, String title, List<String> items, IconData icon,
      {bool infoIcon = false}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenWidth * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: infoIcon ? Colors.grey : Colors.green,
                      size: screenWidth * 0.05,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: infoIcon ? Colors.grey[600] : Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFQAUI(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // FAQ Section
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical:screenWidth*0.05 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently asked questions',
            style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: screenHeight * 0.02),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context,index){
                return ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  iconColor: Colors.black,
                  collapsedShape: RoundedRectangleBorder(
                    side: BorderSide.none,  // No border when collapsed
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none
                  ),
                  title: Text(
                    'Will the professionals follow all safety measures?',
                    style: TextStyle(fontSize: screenWidth * 0.038, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Text(
                      'Yes. Our professionals will take all the necessary measures like social distancing, wearing a mask, etc.',
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                  ],
                );
              }),

          SizedBox(height: screenHeight * 0.005),

        ],
      ),
    );
  }

  Widget _buildShareUI(BuildContext context){
    double screenHeight =  MediaQuery.of(context).size.height;
    double screenWidth =  MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical:screenWidth*0.05 ),
      child: Center(
        child: Column(
          children: [
            Text('Share this service with your loved ones',style: TextStyle(fontSize: screenWidth * 0.04),),
            SizedBox(height: screenHeight * 0.01),
            SizedBox(
              width: screenWidth,
              height: screenWidth * 0.1,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.purple, width: 1),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                icon: Icon(Icons.share, color: Colors.purple),
                label: Text(
                  'Share',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSlider(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05,vertical: screenWidth*0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '★ 4.80',
            style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w600,height: 1.1),
          ),
          // SizedBox(height: screenHeight * 0.005),
          Text(
            '77K reviews',
            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
          ),

          // Rating Breakdown
          SizedBox(height: screenHeight * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingBar(screenWidth, screenHeight, '★ 5', 92, '71K'),
              _buildRatingBar(screenWidth, screenHeight, '★ 4', 60, '3K'),
              _buildRatingBar(screenWidth, screenHeight, '★ 3', 40, '1K'),
              _buildRatingBar(screenWidth, screenHeight, '★ 2', 23, '807'),
              _buildRatingBar(screenWidth, screenHeight, '★ 1', 10, '1K'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(double screenWidth, double screenHeight, String rating, double percentage, String count) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: Row(
        children: [
          Text(rating, style: TextStyle(fontSize: screenWidth * 0.04)),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            flex: 5,
            child: Container(
              height: screenHeight * 0.009,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded( flex: 2,child: Text(count, style: TextStyle(fontSize: screenWidth * 0.04))),
        ],
      ),
    );
  }

  Widget _buildReviewList(BuildContext context){
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05,vertical: screenWidth*0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviews Section
          Row(
            children: [
              Text(
                'All reviews',
                style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: Colors.indigoAccent,
                  overlayColor: Colors.transparent, // No overlay color on tap
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Remove border radius
                ),
                child: Text(
                  'Filter (1)',
                  style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          SizedBox(height: screenWidth * 0.01),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return _buildReviewItem(screenWidth, screenHeight);
              })
        ],
      ),
    );
  }

  Widget _buildReviewItem(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // first row name & icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kuldeep Munshi',
                      style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Feb 18, 2025 • For Exhaust fan cleaning, Ceiling Fan Cleaning mini, Heater',
                      style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.05,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.026, vertical: screenHeight * 0.005),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                child: Text('★ 5', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),
          Text(
            'The person was polite and had the knowledge of work.',
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
          SizedBox(height: screenHeight * 0.01),

        ],
      ),
    );
  }

  String _calculateDiscount({required num price, required num strikePrice}) {
    if (strikePrice <= 0 || price >= strikePrice) {
      return "0%";
    }

    final discount = ((strikePrice - price) / strikePrice) * 100;
    return "${discount.toStringAsFixed(0)}%";
  }

  bool _hasDiscount({required num price, required num strikePrice}) {
    if (strikePrice <= 0 || price >= strikePrice) {
      return false;
    }

    final discount = ((strikePrice - price) / strikePrice) * 100;
    return discount > 0;
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
