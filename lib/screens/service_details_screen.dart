import 'package:flutter/material.dart';

import '../utilities/cust_colors.dart';


void showServiceDetails(BuildContext context){
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height
      ),
      builder: (_){
        return _ServiceDetails(
          onDismiss: (){
            Navigator.of(_).pop();
          },
        );
      });
}


class _ServiceDetails extends StatelessWidget {
  final VoidCallback? onDismiss;
  _ServiceDetails({super.key, this.onDismiss});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth / 375;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: IconButton(
              onPressed: onDismiss,
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
              decoration: BoxDecoration(
                color: CustColors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAddProductUI(context),
                    SizedBox(height: screenHeight * 0.01,),
                    _buildShareUI(context),
                    _buildFQAUI(context),
                    _buildReviewSlider(context),
                    _buildReviewList(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.05),
                topRight: Radius.circular(screenWidth * 0.05)),
            child: Image.network(
              'https://storage.googleapis.com/a1aa/image/0foaRz7Z2MVoMNhFivQz1P098Q8N-K-usScNfud8mgY.jpg',
              height: screenHeight * 0.3,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          // Product details
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Info Section
                      Text(
                        'Flush tank repair (external PVC)',
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
                          Text(
                            '₹99',
                            style: TextStyle(
                                fontSize: screenWidth * 0.043,
                                fontWeight: FontWeight.w600,
                                height: 1.1),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Text(
                            '• 30 mins',
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
                          Text(
                            '₹88 off',
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

                SizedBox(
                  width: screenWidth * 0.08,
                ),
                // Add Button
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: Colors.black12, width: 0.5),
                      foregroundColor: Colors.black,
                      elevation: 1,
                      overlayColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            screenWidth * 0.015),
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

}




