import 'package:cleaning_service/shimmer_effect/custom_shimmer_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingShimmerEffect extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(left: 10.0,right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4.0
                  )
                ]
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomShimmerContainer(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                    ),
                  ),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomShimmerContainer(
                                width: screenWidth * 0.5,
                                height: screenWidth * 0.03,
                                borderRadius: BorderRadius.circular( 50.0),
                              ),
                            ),
                            const SizedBox(width: 8.0,),
                            Expanded(
                              flex: 1,
                              child: CustomShimmerContainer(
                                width: screenWidth * 0.15,
                                height: screenWidth * 0.08,
                                borderRadius: BorderRadius.circular( 4.0),
                              ),
                            ),
                          ],
                        ),
                        CustomShimmerContainer(
                          width: screenWidth * 0.4,
                          height: screenWidth * 0.03,
                          borderRadius: BorderRadius.circular( 50.0),
                        ),
                        const SizedBox(height: 4.0,),
                        CustomShimmerContainer(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.03,
                          borderRadius: BorderRadius.circular( 50.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

}