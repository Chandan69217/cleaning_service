import 'package:flutter/material.dart';

import '../utilities/cust_colors.dart';


class ShowAllServices extends StatelessWidget {
  const ShowAllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Plumber'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plumber',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24.0, fontWeight: FontWeight.bold,),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.black,size: 20.0,),
                      SizedBox(width: 4,),
                      Text('4.81 (4.7M bookings)', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8.0,)
                ],
              ),
            ),
            // SizedBox(height: 15),
            _categoriesSection(),
            // SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(top: 2),
              color: Colors.white,
              child: ListView.builder(
                itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                return _detailsSection();
              }),
            ),
          ],
        ),
      ),
    );
  }


  Widget _categoriesSection() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7
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
                padding: EdgeInsets.only(left: 6.0,right: 6.0,top: 6.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(imageUrls[index], width: 70, height: 70, fit: BoxFit.contain)),
              ),
              SizedBox(height: 5),
              Expanded(flex:1,child: Text(categoryNames[index], style: TextStyle(fontSize: 14, ))),
            ],
          );
        },
      ),
    );
  }

  Widget _detailsSection() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bath fittings',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
          SizedBox(height: 15.0,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bath accessory installation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    // SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star_rate_rounded, color: Colors.black,size: 15.0,),
                        SizedBox(width: 3,),
                        Text('4.80 (11K reviews)', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8),decoration: TextDecoration.underline)),
                      ],
                    ),
                    SizedBox(height: 2,),
                    RichText(text: TextSpan(text: '₹69',children: [TextSpan(text: '  •  '),TextSpan(text: '30 min',style:TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.8),fontWeight: FontWeight.normal))],style: TextStyle(fontSize: 11, color: Colors.black,fontWeight: FontWeight.w500),)),
                    Divider(),
                    Text('Small fittings such as towel hanger/shelves, soap dispenser, etc.', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8),height: 1.1)),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove padding
                        overlayColor: Colors.transparent, // No overlay color on tap
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Remove border radius
                      ),
                      child: Text(
                        'View details',
                        style: TextStyle(
                          color: Color(0xFF6b45de),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none, // Optional: Remove any underline (if present)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
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
                      // Image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            'https://storage.googleapis.com/a1aa/image/YOSHv2t9xW16kVsUHq41BVZe0PtXLYzuCEv31oiVrS0.jpg',
                            fit: BoxFit.cover,
                            width: 180,
                            height: 130,
                          ),
                        ),
                      ),

                      // Button at the bottom half of the image
                      Positioned(
                        bottom: -17, // Adjust this value to get the desired overlap
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 20,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.black12, width: 0.5),
                              foregroundColor: Color(0xFF6b45de),
                              elevation: 0,
                              overlayColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              // Handle the button press action
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6b45de),
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
          Divider()
        ],
      ),
    );
  }
}


