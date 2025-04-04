import 'dart:math';

import 'package:cleaning_service/screens/service_details_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/widgets/counter_button.dart';
import 'package:flutter/material.dart';
import '../models/categories_service.dart';
import '../utilities/cust_colors.dart';


class AllServicesListScreen extends StatefulWidget {
  final Category category;

  AllServicesListScreen({super.key,required this.category});

  @override
  State<AllServicesListScreen> createState() => _AllServicesListScreenState();
}

class _AllServicesListScreenState extends State<AllServicesListScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _subCategoryKeys = {}; // Store keys for each subcategory
  Map<String,Map<String,dynamic>> _cartItems = {};
  ValueNotifier<int> totalAmount = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.category.subCategory.length; i++) {
      _subCategoryKeys[i] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.05;
    double subTitleFontSize = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category.categoryName,
              style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold,),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.black, size: titleFontSize* 0.8),
                SizedBox(width: screenWidth * 0.01),
                Text('4.81 (4.7M bookings)', style: TextStyle(fontSize: subTitleFontSize * 0.8, color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search_rounded, size: screenWidth * 0.06),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: Icon(Icons.share_rounded, size: screenWidth * 0.06),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(child: _categoriesSection(context: context,category: widget.category)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Container(
                    color: Colors.white,
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
                    key: _subCategoryKeys[index], // Assign key to each subCategory
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category.subCategory[index].subCategoryName,
                          style: TextStyle(fontSize: screenWidth * 0.055, fontWeight: FontWeight.bold),
                        ),
                        _detailsGroup(context: context, services: widget.category.subCategory[index].services),
                      ],
                    ),
                  );
                },
                childCount: widget.category.subCategory.length,
              ),
            ),
            if(_cartItems.isNotEmpty)
              SliverToBoxAdapter(child: SizedBox(height: screenWidth * 0.2,),)
          ],
        ),
          if(_cartItems.isNotEmpty)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenWidth * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 1,
                        ),
                      ]
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(width: 1.0,),
                        ValueListenableBuilder<int>(
                          valueListenable: totalAmount,
                          builder: (context, value, child) {
                            return Text('₹${value}', style: TextStyle(fontSize: screenWidth * 0.041, fontWeight: FontWeight.w600),textAlign: TextAlign.center,);
                          },
                        ),
                        ElevatedButton(onPressed: (){
                          _cartItems.forEach((key, value) {
                            print("Key: $key, Value: $value");
                          });
                        }, child: Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.14,vertical: (screenWidth * 0.2) * 0.2),
                          textStyle: TextStyle(fontSize: screenWidth * 0.04),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white
                        ),)
                      ],
                    ),
                  ),
                ))
        ]
      ),
    );
  }

  void scrollToIndex(int index) {
    final key = _subCategoryKeys[index];
    if (key != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _categoriesSection({required BuildContext context,required Category category}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.05;
    return Container(
      padding: EdgeInsets.symmetric(vertical:  screenWidth * 0.03,horizontal: screenWidth * 0.05),
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Our ${category.categoryName}',
          //   style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
          // ),
          SizedBox(height: 8.0,),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 375 ? 3 : 4,
              crossAxisSpacing: screenWidth * 0.03,
              mainAxisSpacing: screenWidth * 0.03,
              childAspectRatio: screenWidth < 375 ? 0.9 : 0.7, // Ensures square grid items
            ),
            itemCount: category.subCategory.length,
            itemBuilder: (context, index) {
              List<String> categoryNames = category.subCategory.map((subCategory){
                return subCategory.subCategoryName;
              }).toList();
              final List<String> imageUrls = [
                'assets/pictures/bath_fitting.webp',
                'assets/pictures/basin_sink.webp',
                'assets/pictures/grouting.webp',
                'assets/pictures/water_filter.webp',
                'assets/pictures/drainge.webp',
                'assets/pictures/toilet.webp',
                'assets/pictures/Tap_Mixer.webp',
                'assets/pictures/water_tank.webp',
                'assets/pictures/water_pipe.webp',
                'assets/pictures/book_a_visit.webp'
              ];

              return GestureDetector(
                onTap: (){
                  scrollToIndex(index);
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Image.asset(
                        imageUrls[index],
                        width: screenWidth * 0.2,  // Set width and height equally
                        height: screenWidth * 0.2,  // Set width and height equally
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Expanded(
                      child: Text(
                        categoryNames[index],
                        style: TextStyle(fontSize: screenWidth * 0.035),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis, // If the label is too long, it will be truncated
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );


  }

  Widget _detailsGroup({required BuildContext context,required List<Service> services}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenWidth * 0.03),
        ListView.builder(
          itemCount: services.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _listGropItem(
              service: services[index],
              onAddButtonClicked: (count){
                setState(() {
                  String key = services[index].id.toString();
                  _cartItems.update(
                    key,
                        (existingValue) {
                      existingValue['Qty'] = count;
                      existingValue['Price'] = services[index].price;
                      return existingValue;
                    },
                    ifAbsent: () => {
                      'AppToken': Pref.instance.getString(Consts.token),
                      'ServiceId': services[index].id,
                      'Qty': count,
                      'Price': services[index].price
                    },
                  );
                  _calculateTotalAmount();
                });
              },
              context: context,
              onTap: () {
                showServiceDetails(context,service: services[index]);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _listGropItem({required BuildContext context,VoidCallback? onTap, VoidCallback? onViewDetailsPressed, Function(int cartItemCount)? onAddButtonClicked,required Service service}) {

    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.serviceName, style: TextStyle(fontSize: screenWidth * 0.041, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded, color: Colors.black, size: screenWidth * 0.04),
                        SizedBox(width: 3),
                        Text(
                          '${service.rating} (${service.reviews.length} reviews)',
                          // '4.80 (11K reviews)',
                          style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black.withOpacity(0.8), decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        text: '₹${service.price}',
                        children: [
                          TextSpan(text: '  •  '),
                          TextSpan(
                            text: '${service.duration} min',
                            style: TextStyle(fontSize: screenWidth * 0.039, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.normal),
                          ),
                        ],
                        style: TextStyle(fontSize: screenWidth * 0.039, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(),
                    Text('${service.description}',
                        style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black.withOpacity(0.8), height: 1.1)),
                    TextButton(
                      onPressed: onViewDetailsPressed,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove padding
                        overlayColor: Colors.transparent, // No overlay color on tap
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Remove border radius
                      ),
                      child: Text(
                        'View details',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Color(0xFF6b45de),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none, // Optional: Remove any underline (if present)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                flex: 2,
                child: Container(
                  height: screenWidth * 0.335,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none, // To allow the button to overflow
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(screenWidth * 0.025),
                          child: Image.network(
                            'https://storage.googleapis.com/a1aa/image/YOSHv2t9xW16kVsUHq41BVZe0PtXLYzuCEv31oiVrS0.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -14,
                        left: 0,
                        right: 0,
                        child: StatefulBuilder(
                          builder:(_,refresh)=> Container(
                            height: screenWidth * 0.09,
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                            child: _cartItems.containsKey(service.id.toString())?CounterButton(
                              initialValue: 1,
                              borderColor: Colors.black12,
                              onChanged: (count){
                                if(count<1){
                                  _cartItems.remove(service.id.toString());
                                  if(_cartItems.isNotEmpty){
                                  refresh((){
                                  });
                                  }else{
                                    setState(() {
                                    });
                                  }
                                  return;
                                }
                                String key = service.id.toString();
                                _cartItems.update(
                                  key,
                                      (existingValue) {
                                    existingValue['Qty'] = count;
                                    existingValue['Price'] = service.price;
                                    return existingValue;
                                  },
                                  ifAbsent: () => {
                                    'AppToken': Pref.instance.getString(Consts.token),
                                    'ServiceId': service.id,
                                    'Qty': count,
                                    'Price': service.price
                                  },
                                );
                                _calculateTotalAmount();
                              },
                            ):ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.black12, width: 0.5),
                                foregroundColor: Color(0xFF6b45de),
                                elevation: 0,
                                overlayColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth * 0.012),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: (){
                                if(onAddButtonClicked != null){
                                  onAddButtonClicked.call(1);
                                }
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF6b45de),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  void _calculateTotalAmount()async{
    int Amount = 0;
    for (var entry in _cartItems.entries) {
      Amount += (entry.value['Price'] * entry.value['Qty']) as int;
    }
    totalAmount.value = Amount;
  }

}



