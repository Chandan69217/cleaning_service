import 'dart:async';

import 'package:cleaning_service/screens/all_service_screen.dart';
import 'package:cleaning_service/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/data.dart';
import '../../utilities/cust_colors.dart';


// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     double fontSize = screenWidth * 0.05;
//     double iconSize = screenWidth * 0.07;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             LocationSection(fontSize: fontSize, iconSize: iconSize),
//             UCSection(fontSize: fontSize,iconSize: iconSize,),
//             ReviewsSection(fontSize: fontSize),
//             BottomSection(fontSize: fontSize),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class LocationSection extends StatelessWidget {
// //   final double fontSize;
// //   final double iconSize;
// //
// //   const LocationSection({required this.fontSize, required this.iconSize});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 75.0,
// //       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Expanded(
// //             child: Row(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Icon(FontAwesomeIcons.locationArrow, size: iconSize * 0.9),
// //                 SizedBox(width: 8.0),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           '${Data.user_placemarks.first.locality}',
// //                           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
// //                             fontSize: fontSize * 1.01,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: Text(
// //                           '${Data.address}',
// //                           style: TextStyle(
// //                             fontSize: fontSize * 0.7,
// //                             color: Color(0xFF757575),
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                           maxLines: 1,
// //                           softWrap: true,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           SizedBox(width: 8.0,),
// //           Container(
// //               padding: EdgeInsets.all(5.0),
// //               decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   border: Border.all(color: Colors.grey, width: 1)),
// //               child: Icon(Icons.shopping_cart, size: iconSize)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// class LocationSection extends StatelessWidget {
//   final double fontSize;
//   final double iconSize;
//
//   const LocationSection({required this.fontSize, required this.iconSize});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextStyle titleStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
//       fontSize: fontSize * 1.01,
//       fontWeight: FontWeight.bold,
//     );
//
//     final TextStyle subtitleStyle = TextStyle(
//       fontSize: fontSize * 0.7,
//       color: Color(0xFF757575),
//     );
//
//     return Container(
//       height: 90.0,
//       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 8,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(FontAwesomeIcons.locationArrow, size: iconSize * 0.9),
//                 SizedBox(width: 8.0),
//                 // Location details section
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Flexible(
//                         fit: FlexFit.loose,
//                         child: Text(
//                           '${Data.user_placemarks.first.locality}',
//                           style: titleStyle,
//                           textAlign: TextAlign.justify,
//                         ),
//                       ),
//                       Flexible(
//                         fit: FlexFit.loose,
//                         child: Text(
//                           '${Data.address}',
//                           style: subtitleStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           textAlign: TextAlign.justify,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8.0),
//           // Shopping cart icon
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.all(5.0),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.grey, width: 1),
//               ),
//               child: Icon(Icons.shopping_cart, size: iconSize),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class UCSection extends StatelessWidget {
//   final double fontSize;
//   final double iconSize;
//   const UCSection({required this.iconSize, required this.fontSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'UC got you covered',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               fontSize: fontSize * 1.5,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 2.0),
//           Column(
//             children: [
//               UCItem(
//                 icon: Icons.shield,
//                 text: '2-year unconditional warranty',
//                 fontSize: fontSize*0.85,
//               ),
//               SizedBox(height: 2),
//               UCItem(
//                 icon: Icons.sync,
//                 text: '10-day replacement',
//                 fontSize: fontSize*0.85,
//               ),
//               SizedBox(height: 2),
//               UCItem(
//                 icon: Icons.car_repair_outlined,
//                 text: 'Free 2-day delivery',
//                 fontSize: fontSize*0.85,
//               ),
//               SizedBox(height: 2),
//               UCItem(
//                 icon: Icons.credit_card,
//                 text: 'No cost EMI available',
//                 fontSize: fontSize*0.85,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UCItem extends StatelessWidget {
//   final IconData icon;
//   final String text;
//   final double fontSize;
//
//   const UCItem({
//     required this.icon,
//     required this.text,
//     required this.fontSize,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: fontSize * 1.1),
//         SizedBox(width: 8.0),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: fontSize),
//         ),
//       ],
//     );
//   }
// }
//
// class ReviewsSection extends StatelessWidget {
//   final double fontSize;
//   PageController controller = PageController(viewportFraction: 0.9, keepPage: true);
//
//   ReviewsSection({required this.fontSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 6.0),
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Customer reviews',
//             style: TextStyle(
//               fontSize: fontSize * 1.5,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             'Customers love us! See for yourself.',
//             style: TextStyle(fontSize: fontSize * 0.8, color: Color(0xFF757575)),
//           ),
//           SizedBox(
//             height: 180.0,
//             child: PageView.builder(
//               controller: controller,
//               padEnds: false,
//               itemCount: 4,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0),
//                   child: ReviewCard(
//                     text: '“No more holding the water bottle till it fills up. The pre-sets are great!”',
//                     author: 'Shreya Virmani',
//                     date: 'Dec 22 · Mumbai',
//                     rating: 5,
//                     fontSize: fontSize,
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 8),
//           Align(
//             alignment: Alignment.center,
//             child: SmoothPageIndicator(
//               controller: controller,
//               count: 4,
//               effect: ExpandingDotsEffect(
//                 dotHeight: 6,
//                 dotWidth: 6,
//                 dotColor: Colors.grey,
//                 activeDotColor: CustColors.orange,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ReviewCard extends StatelessWidget {
//   final String text;
//   final String author;
//   final String date;
//   final int rating;
//   final double fontSize;
//
//   const ReviewCard({
//     required this.text,
//     required this.author,
//     required this.date,
//     required this.rating,
//     required this.fontSize,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       margin: EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 3,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: fontSize * 0.7, fontWeight: FontWeight.bold))),
//               SizedBox(width: 10.0),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.star, color: CustColors.white, size: fontSize * 0.7),
//                     SizedBox(width: 1),
//                     Text(
//                       '$rating',
//                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CustColors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Spacer(),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '$author',
//                       style: TextStyle(fontSize: fontSize * 0.5, color: Color(0xFF757575)),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       '$date',
//                       style: TextStyle(fontSize: fontSize * 0.5, color: Color(0xFF757575)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BottomSection extends StatelessWidget {
//   final double fontSize;
//
//   const BottomSection({required this.fontSize});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
//       margin: EdgeInsets.only(top: 6.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Made for India',
//             style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 2.0),
//           Text(
//             'Native is a line of user-friendly innovations here to level up industry standards. Each product has been extensively researched, rigorously tested, & built from scratch alongside industry experts.',
//             style: TextStyle(fontSize: fontSize * 0.8, color: Color(0xFF757575)),
//           ),
//           SizedBox(height: 20.0),
//           Row(
//             children: [
//               NetworkImage(imageUrl: 'https://storage.googleapis.com/a1aa/image/0rl47qjrXyzf5EC1o4pn3nP7tHWELUYQX1zM4uiaRdA.jpg'),
//               NetworkImage(imageUrl: 'https://storage.googleapis.com/a1aa/image/uMbKUse4aYWLEmFpBvfzBwbxclhuuXBrBT0x4T9Q1BE.jpg'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class NetworkImage extends StatelessWidget {
//   final String imageUrl;
//
//   const NetworkImage({required this.imageUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 10.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8.0),
//         child: Image.network(imageUrl, width: 150.0, height: 150.0, fit: BoxFit.cover),
//       ),
//     );
//   }
// }









class TopMenuSection extends StatelessWidget {
  final double fontSize;
  final double iconSize;

  const TopMenuSection({required this.fontSize, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final TextStyle titleStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: fontSize * 1.01,
      fontWeight: FontWeight.w700,
    );

    final TextStyle subtitleStyle = TextStyle(
      fontSize: fontSize * 0.7,
      color: Color(0xFF757575),
    );

    return Container(
      height: screenHeight * 0.37,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Column(
        children: [
          // location sections
          Container(
            height: screenHeight * 0.1,
            padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05, vertical: screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FontAwesomeIcons.locationArrow, size: iconSize * 0.9),
                      SizedBox(width: 8.0),
                      // Location details section
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                '${Data.user_placemarks != null ?Data.user_placemarks!.first.locality : 'N/A'}',
                                style: titleStyle,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                '${Data.address}',
                                style: subtitleStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                // Shopping cart icon
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EmptyCartScreen())),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Icon(Icons.shopping_cart, size: iconSize),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            height: screenHeight * 0.05,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth*0.015 ),
              boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: 1
                // spreadRadius: 1,
              )],
            ),
            child: Row(
              children: [
                Icon(Icons.search,color: Colors.black.withOpacity(0.4),),
                SizedBox(width: 8.0,),
                Text('Search for service',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black.withOpacity(0.4)),),
              ],
            ),
          ),

          // Menu Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: GridView.count(crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 2.7,
                crossAxisSpacing: screenWidth*0.02,
                mainAxisSpacing: screenWidth*0.02,
                children: [
                  MenuItems(label: 'Cleaning', icon: 'assets/icons/vacuum.webp',fontSize: fontSize,),
                  MenuItems(label: 'Water Purifier', icon: 'assets/icons/water-filter.webp',fontSize: fontSize,),
                  MenuItems(label: 'Electrician,   Plumber & Carpenter', icon: 'assets/icons/electrician-service.webp',fontSize: fontSize,),
                  MenuItems(label: 'AC & Appliance Repair', icon: 'assets/icons/air-conditioner.webp',fontSize: fontSize,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MenuItems extends StatelessWidget{
  final String label;
  final String icon;
  final double fontSize;
  const MenuItems({super.key, required this.label,required this.icon,this.fontSize = 12});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(5*(fontSize*0.1)),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth*0.025)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: fontSize*0.7,height: 1.1),)),
          SizedBox(width:fontSize,),
          Image.asset(icon,fit: BoxFit.cover,width: 10*(fontSize*0.2),height: 10*(fontSize*0.2),),
        ],
      ),
    );
  }

}

class CategorySlideCard extends StatefulWidget {
  @override
  _CategorySlideCardState createState() => _CategorySlideCardState();
}

class _CategorySlideCardState extends State<CategorySlideCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> imageUrls = [
    'https://img.freepik.com/free-photo/plumbing-repair-service_181624-27146.jpg?t=st=1740204179~exp=1740207779~hmac=88ee9c247eeb54030d6cf20311ffcbe7b4221c570b32e964f638b770f53d3f8c&w=1800',
    'https://img.freepik.com/free-photo/side-view-man-working-as-plumber_23-2150746307.jpg?t=st=1740204214~exp=1740207814~hmac=d667f3b872dd3a7957fc26c458cfd2ae4f8480b378bea3ff7ce4b503eefc99c5&w=1800',
    'https://img.freepik.com/free-photo/service-man-adjusting-house-heating-system_1303-26545.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/asian-plumber-blue-overalls-clearing-blockage-drain_1098-17773.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/man-electrical-technician-working-switchboard-with-fuses-installation-connection-electrical-equipment-close-up_169016-5082.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/electrician-builder-with-beard-worker-white-helmet-work-installation-lamps-height-professional-overalls-with-drill-background-repair-site_169016-7328.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/electrician-builder-work-examines-cable-connection-electrical-line-fuselage-industrial-switchboard-professional-overalls-with-electrician-s-tool_169016-8831.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/repairman-doing-air-conditioner-service_1303-26541.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/hvac-technician-working-capacitor-part-condensing-unit_155003-20894.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid'
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.page == imageUrls.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: screenHeight*0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth*0.015),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                        // spreadRadius: 1,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrls[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            // Text overlay at the top left
            Positioned(
              top: (screenHeight*0.23)*0.1,
              left: (screenHeight*0.23)*0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Native Water Purifiers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      height: 1.1
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Needs no service for 2 years',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.038,
                    ),
                  ),
                ],
              ),
            ),
            // Button at the bottom left
            Positioned(
              bottom: (screenHeight*0.23)*0.13,
              left: (screenHeight*0.23)*0.1,
              child: SizedBox(
                width: (screenHeight*0.23)*0.55,
                height: (screenHeight*0.23)*0.21,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Book now',
                    style: TextStyle(fontSize: (screenHeight*0.23)*0.06),
                  ),
                ),
              ),
            ),
            // Indicator
            Positioned(
              bottom: (screenHeight*0.23)*0.05,
              left: (screenHeight*0.23)*0.1,
              child: Row(
                children: List.generate(imageUrls.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: (screenHeight*0.23)*0.041,
                    width: _currentPage == index ? (screenHeight*0.23)*0.11 : (screenHeight*0.23)*0.041,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class HomeScreen extends StatelessWidget {
  List<String> imageUrls = [
    'https://img.freepik.com/free-photo/plumbing-repair-service_181624-27146.jpg?t=st=1740204179~exp=1740207779~hmac=88ee9c247eeb54030d6cf20311ffcbe7b4221c570b32e964f638b770f53d3f8c&w=1800',
    'https://img.freepik.com/free-photo/side-view-man-working-as-plumber_23-2150746307.jpg?t=st=1740204214~exp=1740207814~hmac=d667f3b872dd3a7957fc26c458cfd2ae4f8480b378bea3ff7ce4b503eefc99c5&w=1800',
    'https://img.freepik.com/free-photo/service-man-adjusting-house-heating-system_1303-26545.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/asian-plumber-blue-overalls-clearing-blockage-drain_1098-17773.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/man-electrical-technician-working-switchboard-with-fuses-installation-connection-electrical-equipment-close-up_169016-5082.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/electrician-builder-with-beard-worker-white-helmet-work-installation-lamps-height-professional-overalls-with-drill-background-repair-site_169016-7328.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/electrician-builder-work-examines-cable-connection-electrical-line-fuselage-industrial-switchboard-professional-overalls-with-electrician-s-tool_169016-8831.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/repairman-doing-air-conditioner-service_1303-26541.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid',
    'https://img.freepik.com/free-photo/hvac-technician-working-capacitor-part-condensing-unit_155003-20894.jpg?ga=GA1.1.521463082.1740204178&semt=ais_hybrid'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.05;
    double iconSize = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: CustColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopMenuSection(fontSize: fontSize, iconSize: iconSize),
            Container(
              margin: EdgeInsets.only(top: screenWidth * 0.01),
              padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05, vertical: screenWidth*0.02),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  CategorizedService(
                    label: 'Most booked service',
                    fontSize: fontSize,
                    imagesUrl: imageUrls,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CategorySlideCard(),
                  SizedBox(height: screenHeight * 0.02),
                  CategorizedService(
                    label: 'Quick home repairs',
                    fontSize: fontSize,
                    imagesUrl: imageUrls,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CategorizedService extends StatelessWidget {
  final double fontSize;
  final label;
  List<String> imagesUrl;
  CategorizedService({required this.label, required this.fontSize, required this.imagesUrl});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double gridSpacing = screenWidth * 0.03;

    return Container(
      height: screenWidth*0.66,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: fontSize),
              ),
              TextButton(
                onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowAllServices())); },
                child: Text('See all', style: TextStyle(fontSize: fontSize*0.8)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imagesUrl.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  image: imagesUrl[index],
                  label: 'Intense bathroom cleaning',
                  rating: '4.78(1.9M)',
                  price: '519',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String image;
  final String label;
  final String rating;
  final String price;
  CategoryCard({required this.image, required this.label, required this.rating, required this.price,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              image,
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
          ),
          // Spacer(),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              children: [
                Icon(Icons.star, size: 15),
                SizedBox(width: 2),
                Text(
                  rating,
                  style: TextStyle(fontSize: screenWidth < 600 ? 12 : 14,height: 1.1),
                ),
              ],
            ),
          ),
          // SizedBox(height: 2),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              children: [
                Icon(Icons.currency_rupee_rounded, size: 15),
                SizedBox(width: 2),
                Text(
                  price,
                  style: TextStyle(fontSize: screenWidth < 600 ? 12 : 14,height: 1.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
