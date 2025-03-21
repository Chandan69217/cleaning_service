import 'package:cleaning_service/screens/service_details_screen.dart';
import 'package:flutter/material.dart';
import '../models/categories_service.dart';
import '../utilities/cust_colors.dart';


class AllServicesListScreen extends StatelessWidget {
  final bool? isShowServiceDetails;
  final Service? service;
  const AllServicesListScreen({super.key, this.isShowServiceDetails = false,this.service});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth * 0.05;
    double subTitleFontSize = screenWidth * 0.04;

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(isShowServiceDetails!){
        showServiceDetails(context,service: service);
      }
    });
    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text(
          'Plumber',
          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, size: screenWidth * 0.06),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share_rounded, size: screenWidth * 0.06),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.015),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plumber',
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.black, size: titleFontSize),
                      SizedBox(width: screenWidth * 0.01),
                      Text('4.81 (4.7M bookings)', style: TextStyle(fontSize: subTitleFontSize, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.02),
                ],
              ),
            ),
            _categoriesSection(context: context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              margin: EdgeInsets.only(top: 2),
              color: Colors.white,
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _detailsGroup(context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriesSection({required BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth < 375 ? 3 : 4,
          crossAxisSpacing: screenWidth * 0.03,
          mainAxisSpacing: screenWidth * 0.03,
          childAspectRatio: screenWidth < 375 ? 0.9 : 0.7, // Ensures square grid items
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          List<String> categoryNames = [
            'Bath fittings', 'Basin & sink', 'Grouting', 'Water filter', 'Drainage', 'Toilet', 'Tap & mixer', 'Water tank', 'Water pipes', 'Book a visit'
          ];

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

          return Column(
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
          );
        },
      ),
    );


  }

  Widget _detailsGroup({required BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bath fittings',
            style: TextStyle(fontSize: screenWidth * 0.055, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenWidth * 0.03),
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _listGropItem(
                context: context,
                onTap: () {
                  showServiceDetails(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listGropItem({required BuildContext context,VoidCallback? onTap, VoidCallback? onViewDetailsPressed, Function(int cartItemCount)? onAddButtonClicked}) {
    int _itemCount = 0;
    bool _isAdd = false;
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
                    Text('Bath accessory installation', style: TextStyle(fontSize: screenWidth * 0.041, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded, color: Colors.black, size: screenWidth * 0.04),
                        SizedBox(width: 3),
                        Text(
                          '4.80 (11K reviews)',
                          style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black.withOpacity(0.8), decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    RichText(
                      text: TextSpan(
                        text: '₹69',
                        children: [
                          TextSpan(text: '  •  '),
                          TextSpan(
                            text: '30 min',
                            style: TextStyle(fontSize: screenWidth * 0.039, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.normal),
                          ),
                        ],
                        style: TextStyle(fontSize: screenWidth * 0.039, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(),
                    Text('Small fittings such as towel hanger/shelves, soap dispenser, etc.',
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
                            child: ElevatedButton(
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
                                refresh((){
                                  _isAdd = true;
                                  _itemCount = 1;
                                });
                                if(onAddButtonClicked != null){
                                  onAddButtonClicked.call(_itemCount);
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

}



