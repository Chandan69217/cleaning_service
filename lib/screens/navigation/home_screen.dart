import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/data.dart';
import '../../utilities/cust_colors.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LocationSection(),
            UCSection(),
            ReviewsSection(),
            BottomSection(),
          ],
        ),
      ),
    );
  }
}




class LocationSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.locationArrow),
                SizedBox(width: 8.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Data.user_placemarks.first.locality}',
                      style:Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,),
                    ),
                    Text(
                      '${Data.address}',
                      style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey,width: 1)
              ),
              child: Icon(Icons.shopping_cart, size: 30)),
        ],
      ),
    );
  }
}

class UCSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UC got you covered',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              UCItem(
                icon: Icons.shield,
                text: '2-year unconditional warranty',
              ),
              SizedBox(height: 2,),
              UCItem(
                icon: Icons.sync,
                text: '10-day replacement',
              ),
              SizedBox(height: 2,),
              UCItem(
                icon: Icons.car_repair_outlined,
                text: 'Free 2-day delivery',
              ),
              SizedBox(height: 2,),
              UCItem(
                icon: Icons.credit_card,
                text: 'No cost EMI available',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UCItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const UCItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 8.0),
        Text(text, style:Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class ReviewsSection extends StatelessWidget {
  PageController controller = PageController(viewportFraction: 0.9,keepPage: true,);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Customer reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Customers love us! See for yourself.',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          SizedBox(
            height: 180.0,
            child: PageView.builder(
              controller: controller,
              padEnds: false,
              itemCount: 4,

              itemBuilder: (BuildContext context, int index) {
                return  Padding(
                  padding: const EdgeInsets.only(right: 8.0,top: 8.0,left: 8.0),
                  child: ReviewCard(
                    text: '“No more holding the water bottle till it fills up. The pre-sets are great!”',
                    author: 'Shreya Virmani',
                    date: 'Dec 22 · Mumbai',
                    rating: 5,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8,),
          Align(
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                dotColor: Colors.grey,
                activeDotColor: CustColors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String text;
  final String author;
  final String date;
  final int rating;

  const ReviewCard({
    required this.text,
    required this.author,
    required this.date,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.0,fontWeight: FontWeight.bold,))),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: CustColors.white, size: 20),
                    SizedBox(width: 1,),
                    Text('$rating', style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: CustColors.white,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '$author',
                      style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$date',
                      style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Made for India',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Native is a line of user-friendly innovations here to level up industry standards. Each product has been extensively researched, rigorously tested, & built from scratch alongside industry experts.',
            style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              NetworkImage(imageUrl: 'https://storage.googleapis.com/a1aa/image/0rl47qjrXyzf5EC1o4pn3nP7tHWELUYQX1zM4uiaRdA.jpg'),
              NetworkImage(imageUrl: 'https://storage.googleapis.com/a1aa/image/uMbKUse4aYWLEmFpBvfzBwbxclhuuXBrBT0x4T9Q1BE.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}

class NetworkImage extends StatelessWidget {
  final String imageUrl;

  const NetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(imageUrl, width: 150, height: 150, fit: BoxFit.cover),
      ),
    );
  }
}
