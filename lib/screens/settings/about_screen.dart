import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutScreen extends StatelessWidget {
  final String appVersion = "7.5.91 R455";

  final String privacyPolicy = '''
We value your privacy. We collect minimal personal data and use it to improve your experience. We never share your data with third parties without consent.
''';

  final String termsOfService = '''
By using our app, you agree to follow all local laws. The app is provided "as-is" without warranties. Misuse of the app may lead to account suspension.
''';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("About UC", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: screenWidth * 0.12,
                backgroundColor: Colors.deepPurple.shade100,
                child: Icon(Icons.info_outline, size: screenWidth * 0.12, color: Colors.deepPurple),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Column(
                children: [
                  Text("UC", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Version $appVersion", style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            Text("About", style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(
              "UC is a trusted platform that helps users manage their bookings, addresses, payments, and more – all in one place.",
              style: TextStyle(fontSize: screenWidth * 0.038, color: Colors.black87),
            ),
            SizedBox(height: screenHeight * 0.03),

            Text("Legal", style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),

            _cleanExpansion("Privacy Policy", privacyPolicy, screenWidth),
            SizedBox(height: 4),
            _cleanExpansion("Terms of Service", termsOfService, screenWidth),

            SizedBox(height: screenHeight * 0.04),

            Center(
              child: Text(
                "© ${DateTime.now().year} Your Company Name",
                style: TextStyle(fontSize: screenWidth * 0.033, color: Colors.grey),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _cleanExpansion(String title, String content, double screenWidth) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(top: 8, bottom: 8),
        collapsedIconColor: Colors.black,
        iconColor: Colors.black,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        shape: Border(), // Remove bottom line
        collapsedShape: Border(), // Remove bottom line when collapsed
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        children: [
          Text(
            content,
            style: TextStyle(fontSize: screenWidth * 0.037, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }
}




// class AboutScreen extends StatelessWidget {
//   final String appVersion = "7.5.91 R455";
//   final String companyName = "Your Company Name";
//   final String description =
//       "UC is a trusted platform that helps users manage their bookings, addresses, payments, and more – all in one place.";
//
//   final String privacyPolicyUrl = "https://yourapp.com/privacy-policy";
//   final String termsOfServiceUrl = "https://yourapp.com/terms";
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("About UC", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // App Logo or Icon
//             Center(
//               child: CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.deepPurple.shade100,
//                 child: Icon(Icons.info_outline, size: 50, color: Colors.deepPurple),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // App Name & Version
//             Center(
//               child: Column(
//                 children: [
//                   Text("UC", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4),
//                   Text("Version $appVersion", style: TextStyle(color: Colors.grey[600])),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 24),
//             Text(
//               "About",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               description,
//               style: TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//
//             SizedBox(height: 24),
//             Text(
//               "Legal",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               title: Text("Privacy Policy"),
//               trailing: Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => _launchUrl(privacyPolicyUrl),
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               title: Text("Terms of Service"),
//               trailing: Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => _launchUrl(termsOfServiceUrl),
//             ),
//
//             SizedBox(height: 24),
//             Center(
//               child: Text(
//                 "© ${DateTime.now().year} $companyName",
//                 style: TextStyle(fontSize: 13, color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _launchUrl(String url) async {
//     final uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       throw 'Could not launch $url';
//     }
//   }
//
// }
