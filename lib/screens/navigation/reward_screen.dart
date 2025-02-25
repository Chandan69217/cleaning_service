import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class RewardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSizeScaling = screenWidth / 375;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Refer & Earn',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18*fontSizeScaling)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenWidth * 0.02,
              ),
              Text(
                'Refer and get FREE services',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  height: 1.1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(height: screenHeight * 0.02),
              Text(
                'Invite your friends to try Urban Company services. They get instant ₹100 off. You win ₹100 once they take a service.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: screenWidth * 0.09),
              _ReferViaSection(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.05),
              _HowItWorksSection(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  _LinkButton(text: 'Terms and conditions', screenWidth: screenWidth),
                  _LinkButton(text: 'FAQs', screenWidth: screenWidth),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              _FooterSection(screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferViaSection extends StatelessWidget {
  final double screenWidth;

  _ReferViaSection({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.white,
              child: Text(
              'Refer via',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.black,
              ),
                        ),
            ),
          ]
        ),
        SizedBox(height: screenWidth * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _IconButton(label:'Whatsapp',imageUrl: 'https://storage.googleapis.com/a1aa/image/Zqjc4ih6Iag7j6vmmib3xHGJYoUWGkJT7IIGTUPDLkI.jpg'),
            _IconButton(label:'Messenger',imageUrl: 'https://storage.googleapis.com/a1aa/image/KlAQhyhDS-FTGQhu8wy1wwzOsNlerx19r6Hvf6KQxP4.jpg'),
            _IconButton(label:'Copy Link',imageUrl: 'https://storage.googleapis.com/a1aa/image/4cKS9-DjxeHYqvEobgIk3di4D4UyI0ScaQ7JijNnkhc.jpg'),
          ],
        ),
        SizedBox(height: screenWidth * 0.02),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final String imageUrl;
  final String label;

  _IconButton({required this.imageUrl,required this.label});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Image.network(imageUrl, width: 50, height: 50),
        ),
        Text(label,style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: Colors.grey[600],
        ),
          textAlign: TextAlign.center,),
      ],
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  final double screenWidth;

  _HowItWorksSection({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How it works?',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenWidth * 0.04),
          _HowItWorksList(screenWidth: screenWidth),
        ],
      ),
    );
  }
}

class _HowItWorksList extends StatelessWidget {
  final double screenWidth;

  _HowItWorksList({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HowItWorksListItem(step: '1',text: 'Invite your friends & get rewarded', screenWidth: screenWidth),
        _HowItWorksListItem(step: '2',text: 'They get ₹100 on their first service', screenWidth: screenWidth),
        _HowItWorksListItem(step: '3',text: 'You get ₹100 once their service is completed', screenWidth: screenWidth),
      ],
    );
  }
}

class _HowItWorksListItem extends StatelessWidget {
  final String text;
  final double screenWidth;
  final String step;

  _HowItWorksListItem({required this.step, required this.text, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.1),
            radius: screenWidth * 0.03,
            child: Text(step,
            style: TextStyle(color: Colors.grey,height: 1.1,fontWeight: FontWeight.bold,),),
          ),
          SizedBox(width: screenWidth * 0.02,),
          Expanded(
            child: Text(
            text,
            style: TextStyle(
              height: 1.1,
              fontSize: screenWidth * 0.04,
            ),
                    ),
          ),
        ]
      ),
    );
  }
}


class _LinkButton extends StatelessWidget {
  final String text;
  final double screenWidth;

  _LinkButton({required this.text, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.007,
          backgroundColor: Colors.blue,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.035),
          ),
        ),
      ],
    );
  }
}

class _FooterSection extends StatelessWidget {
  final double screenWidth;

  _FooterSection({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You are yet to earn any scratch cards',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            height: 1.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        // SizedBox(height: screenWidth * 0.02),
        Text(
          'Start referring to get surprises',
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[600],),
        ),
        SizedBox(height: screenWidth * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              'https://storage.googleapis.com/a1aa/image/FWKmFbADAJLb6_0Kk-h5fi_hMOTSRSHoRKifUYovtSQ.jpg',
              width: screenWidth * 0.05,
              height: screenWidth * 0.05,
            ),
            SizedBox(width: 8),
            Text(
              'Earn ₹100 on every successful referral',
              style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
