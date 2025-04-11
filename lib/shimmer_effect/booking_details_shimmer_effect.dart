import 'package:cleaning_service/shimmer_effect/custom_shimmer_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingDetailsShimmerEffect extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: CustomShimmerContainer(borderRadius: BorderRadius.circular(30.0),),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomShimmerContainer(
                              height: 15.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          CustomShimmerContainer(
                            width: 80.0,
                            height: 40.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),


            const SizedBox(height: 40),
            const CustomShimmerContainer(
              height: 15.0,
              width: 150.0,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            //
            const SizedBox(height: 30),
            const CustomShimmerContainer(
              height: 15.0,
              width: 150.0,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),
            const SizedBox(height: 12.0,),
            CustomShimmerContainer(
              width: screenWidth,
              height: 20.0,
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomShimmerContainer(
                    height: 55.0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomShimmerContainer(
                    height: 55.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}