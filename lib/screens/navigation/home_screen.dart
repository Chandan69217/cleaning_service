import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/data.dart';
import '../../utilities/cust_colors.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.05; // 5% of screen width for font size
    double iconSize = screenWidth * 0.07; // 8% of screen width for icons

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LocationSection(fontSize: fontSize, iconSize: iconSize),
            UCSection(fontSize: fontSize,iconSize: iconSize,),
            ReviewsSection(fontSize: fontSize),
            BottomSection(fontSize: fontSize),
          ],
        ),
      ),
    );
  }
}

class LocationSection extends StatelessWidget {
  final double fontSize;
  final double iconSize;

  const LocationSection({required this.fontSize, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
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
                Icon(FontAwesomeIcons.locationArrow, size: iconSize * 0.9),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${Data.user_placemarks.first.locality}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: fontSize * 1.01,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${Data.address}',
                          style: TextStyle(
                            fontSize: fontSize * 0.7,
                            color: Color(0xFF757575),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0,),
          Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Icon(Icons.shopping_cart, size: iconSize)),
        ],
      ),
    );
  }
}

class UCSection extends StatelessWidget {
  final double fontSize;
  final double iconSize;
  const UCSection({required this.iconSize, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UC got you covered',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontSize * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.0),
          Column(
            children: [
              UCItem(
                icon: Icons.shield,
                text: '2-year unconditional warranty',
                fontSize: fontSize*0.85,
              ),
              SizedBox(height: 2),
              UCItem(
                icon: Icons.sync,
                text: '10-day replacement',
                fontSize: fontSize*0.85,
              ),
              SizedBox(height: 2),
              UCItem(
                icon: Icons.car_repair_outlined,
                text: 'Free 2-day delivery',
                fontSize: fontSize*0.85,
              ),
              SizedBox(height: 2),
              UCItem(
                icon: Icons.credit_card,
                text: 'No cost EMI available',
                fontSize: fontSize*0.85,
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
  final double fontSize;

  const UCItem({
    required this.icon,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: fontSize * 1.1),
        SizedBox(width: 8.0),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: fontSize),
        ),
      ],
    );
  }
}

class ReviewsSection extends StatelessWidget {
  final double fontSize;
  PageController controller = PageController(viewportFraction: 0.9, keepPage: true);

  ReviewsSection({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.0),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Customer reviews',
            style: TextStyle(
              fontSize: fontSize * 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Customers love us! See for yourself.',
            style: TextStyle(fontSize: fontSize * 0.8, color: Color(0xFF757575)),
          ),
          SizedBox(
            height: 180.0,
            child: PageView.builder(
              controller: controller,
              padEnds: false,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0, left: 8.0),
                  child: ReviewCard(
                    text: '“No more holding the water bottle till it fills up. The pre-sets are great!”',
                    author: 'Shreya Virmani',
                    date: 'Dec 22 · Mumbai',
                    rating: 5,
                    fontSize: fontSize,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
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
  final double fontSize;

  const ReviewCard({
    required this.text,
    required this.author,
    required this.date,
    required this.rating,
    required this.fontSize,
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
              Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: fontSize * 0.7, fontWeight: FontWeight.bold))),
              SizedBox(width: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: CustColors.white, size: fontSize * 0.7),
                    SizedBox(width: 1),
                    Text(
                      '$rating',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CustColors.white, fontWeight: FontWeight.bold),
                    ),
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
                      style: TextStyle(fontSize: fontSize * 0.5, color: Color(0xFF757575)),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$date',
                      style: TextStyle(fontSize: fontSize * 0.5, color: Color(0xFF757575)),
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
  final double fontSize;

  const BottomSection({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      margin: EdgeInsets.only(top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Made for India',
            style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.0),
          Text(
            'Native is a line of user-friendly innovations here to level up industry standards. Each product has been extensively researched, rigorously tested, & built from scratch alongside industry experts.',
            style: TextStyle(fontSize: fontSize * 0.8, color: Color(0xFF757575)),
          ),
          SizedBox(height: 20.0),
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
      padding: EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(imageUrl, width: 150.0, height: 150.0, fit: BoxFit.cover),
      ),
    );
  }
}
