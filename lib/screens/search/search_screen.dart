import 'package:flutter/material.dart';



class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   title:,
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5,color: Colors.black38))
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:  screenWidth * 0.05,vertical: screenWidth * 0.04),
                child: Container(
                  padding: EdgeInsets.only(right: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF6C63FF),
                        size: screenWidth * 0.06,
                      ),),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Look for services',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: screenWidth*0.04,fontWeight: FontWeight.normal)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  // Trending Searches Header
                  Text(
                    'Trending searches',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Tags Section
                  Wrap(
                    spacing: screenWidth * 0.03,
                    runSpacing: screenWidth * 0.02,
                    children: [
                      _buildTag(context, 'Professional cleaning'),
                      _buildTag(context, 'Electricians'),
                      _buildTag(context, 'Carpenters'),
                      _buildTag(context, 'Washing machine repair'),
                      _buildTag(context, 'Ro repair'),
                      _buildTag(context, 'Refrigerator repair'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Custom Widget to Build Tags
  Widget _buildTag(BuildContext context, String text) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.028, vertical: screenWidth * 0.025),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.025),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up,
            color: Color(0xFF6C63FF),
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.01),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}
