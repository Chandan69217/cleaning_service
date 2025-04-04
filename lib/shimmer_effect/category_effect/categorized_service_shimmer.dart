import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../custom_shimmer_container.dart';







class HomeScreenCategorizedShimmer extends StatelessWidget {

  final int itemCount;

  const HomeScreenCategorizedShimmer({
    Key? key,
    this.itemCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: screenWidth * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05, vertical: screenWidth*0.02),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShimmerContainer(
                width: screenWidth * 0.6,
                height: screenWidth * 0.05,
                borderRadius: BorderRadius.circular(20.0),
              ),
              CustomShimmerContainer(
                borderRadius: BorderRadius.circular(100.0),
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
              )
            ],
          ),
          SizedBox(height: screenWidth * 0.04,),
          CustomShimmerContainer(
            height:screenWidth * 0.11,
            width: screenWidth,
          ),
          SizedBox(height: screenWidth * 0.04,),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.7,
            crossAxisSpacing: screenWidth * 0.02,
            mainAxisSpacing: screenWidth * 0.02,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              CustomShimmerContainer(),
              CustomShimmerContainer(),
              CustomShimmerContainer(),
              CustomShimmerContainer(),
            ],
          ),
          SizedBox(height: screenWidth * 0.06,),
          _CategorizedServiceShimmer(),
          _CategorySlideCard(),
          SizedBox(height: screenHeight * 0.02),
          _CategorizedServiceShimmer(),
        ],
      ),
    );
  }
}


class _CategorizedServiceShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth*0.6,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomShimmerContainer(width: screenWidth * 0.6,height: screenWidth * 0.04,),
              CustomShimmerContainer(width: screenWidth * 0.15,height: screenWidth * 0.06,borderRadius: BorderRadius.circular(20.0),),
            ],
          ),
          SizedBox(height: 10.0,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _CategoryCardShimmer();
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _CategoryCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth*0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmerContainer(
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
          ),
          SizedBox(height: 8.0),
          Flexible(
            fit: FlexFit.loose,
            child: CustomShimmerContainer(
              height: screenWidth * 0.022,
              width: screenWidth * 0.28,
            ),
          ),
         SizedBox(height: 12.0,),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              children: [
                CustomShimmerContainer(
                  width: screenWidth * 0.015,
                  height: screenWidth * 0.015,
                ),
                SizedBox(width: 2),
                CustomShimmerContainer(
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.018,
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              children: [
                CustomShimmerContainer(
                  width: screenWidth * 0.015,
                  height: screenWidth * 0.015,
                ),
                SizedBox(width: 2),
                CustomShimmerContainer(
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.018,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _CategorySlideCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: CustomShimmerContainer(
        height: screenHeight*0.23,
      ),
    );
  }
}






