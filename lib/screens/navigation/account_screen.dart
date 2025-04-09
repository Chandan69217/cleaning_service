import 'package:cleaning_service/screens/settings/about_screen.dart';
import 'package:cleaning_service/screens/authentication/login_screen.dart';
import 'package:cleaning_service/screens/notification_and_support/help_and_supprot_screen.dart';
import 'package:cleaning_service/screens/settings/language_screen.dart';
import 'package:cleaning_service/screens/payments_and_address/manage_addresses_screen.dart';
import 'package:cleaning_service/screens/payments_and_address/manange_payments_screen.dart';
import 'package:cleaning_service/screens/navigation/bookings_screen.dart';
import 'package:cleaning_service/screens/notification_and_support/notification_screen.dart';
import 'package:cleaning_service/screens/settings/privacy_and_security_screen.dart';
import 'package:cleaning_service/screens/settings/theme_screen.dart';
import 'package:cleaning_service/screens/payment_and_address/wallet_screen.dart';
import 'package:cleaning_service/utilities/const.dart';
import 'package:cleaning_service/utilities/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? mobileNo;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    mobileNo = Pref.instance.getString(Consts.mobileNo);
  }

  // @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double screenHeight = MediaQuery.of(context).size.height;
  //
  //   return Scaffold(
  //     backgroundColor: CustColors.white,
  //     appBar: AppBar(
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       title: Padding(
  //         padding: EdgeInsets.only(left: 8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Verified Customer',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: screenWidth * 0.05,
  //               ),
  //             ),
  //             Text(
  //               mobileNo != null ? '+91 $mobileNo' : 'N/A',
  //               style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.edit, color: Colors.black,size: screenWidth * 0.052,),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             color: Colors.white,
  //             padding: EdgeInsets.all(screenWidth * 0.05,),
  //             child: GridView.count(
  //               crossAxisCount: 3,
  //               physics: NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               crossAxisSpacing: screenWidth * 0.02,
  //               mainAxisSpacing: screenHeight * 0.02,
  //               children: [
  //                 _buildCard(onTap: (){
  //                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingsScreen()));
  //                 },Icons.content_paste, 'My bookings',screenWidth),
  //                 _buildCard(Icons.devices, 'Native devices',screenWidth),
  //                 _buildCard(Icons.headset, 'Help & support',screenWidth),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: screenHeight * 0.01),
  //           Container(
  //             padding: EdgeInsets.symmetric(horizontal: 20.0),
  //             color: Colors.white,
  //             child: Column(
  //               children: [
  //                 ListView(
  //                   physics: NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   children: [
  //                     // _buildListItem(Icons.description, 'My Plans',screenWidth),
  //                     _buildListItem(Icons.account_balance_wallet, 'Wallet',screenWidth),
  //                     // _buildListItem(Icons.account_balance, 'Plus membership',screenWidth),
  //                     // _buildListItem(Icons.star, 'My rating',screenWidth),
  //                     _buildListItem(Icons.location_on, 'Manage addresses',screenWidth),
  //                     _buildListItem(Icons.credit_card, 'Manage payment methods',screenWidth),
  //                     _buildListItem(Icons.settings, 'Settings',screenWidth),
  //                     _buildListItem(Icons.info, 'About UC',screenWidth),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: screenHeight * 0.01),
  //           Container(
  //             color: Colors.white,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               mainAxisSize: MainAxisSize.max,
  //               children: [
  //                 SizedBox(height: screenHeight * 0.04),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   height: screenWidth * 0.11,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Pref.instance.clear();
  //                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginScreen()),(route)=> false);
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.white,
  //                       foregroundColor: Color(0xFFD32F2F),
  //                       side: BorderSide(color: Color(0xFFD32F2F)),
  //                       padding: EdgeInsets.zero,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                     ),
  //                     child: FittedBox(
  //                       child: Text(
  //                         'Logout',
  //                         style: TextStyle(color: Color(0xFFD32F2F), fontSize: (screenWidth * 0.11)*0.4),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 // Footer
  //                 SizedBox(height: screenHeight * 0.04),
  //                 Text(
  //                   'Version 7.5.91 R455',
  //                   style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.033),
  //                 ),
  //                 SizedBox(height: screenHeight * 0.01),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verified Customer',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              Text(
                mobileNo != null ? '+91 $mobileNo' : 'N/A',
                style:
                    TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: Colors.black, size: screenWidth * 0.052),
            onPressed: () {
              _showEditProfileSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: GridView.count(
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: screenWidth * 0.02,
              mainAxisSpacing: screenHeight * 0.02,
              children: [
                _buildCard(onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookingsScreen()));
                }, Icons.content_paste, 'My bookings'),
                _buildCard(Icons.account_balance_wallet,
                    'Wallet',onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WalletScreen()));
                    }),
                _buildCard(Icons.headset, 'Help & support',onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
                }),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          // _buildListItem(
                          //     Icons.description, 'My Plans'),
                          _buildListItem(Icons.person, "Account",onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen()));
                          }),
                          // _buildListItem(Icons.account_balance_wallet,
                          //     'Wallet',onTap: (){
                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WalletScreen()));
                          //     }),
                          // _buildListItem(Icons.account_balance,
                          //     'Plus membership'),
                          // _buildListItem(
                          //     Icons.star, 'My rating'),
                          _buildListItem(Icons.location_on,
                              'Manage addresses',onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ManageAddressesScreen()));
                              }),
                          _buildListItem(Icons.credit_card,
                              'Manage payment methods',onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ManagePaymentScreen()));
                              }),
                          _buildListItem(Icons.notifications_none, "Notifications",onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                          }),
                          _buildListItem(Icons.language, "Language",onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageScreen()));
                          }),
                          _buildListItem(Icons.color_lens_outlined, "Theme",onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ThemeScreen()));
                          }),
                          _buildListItem(Icons.lock_outline, "Privacy & Security",onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySecurityScreen()));
                          }),
                          // _buildListItem(
                          //     Icons.settings, 'Settings',onTap: (){
                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SettingsScreen()));
                          // }),
                          _buildListItem(Icons.info, 'About UC',onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AboutScreen()));
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Footer (Logout Button)
          SizedBox(height: screenHeight * 0.005),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screenWidth * 0.11,
                  child: ElevatedButton(
                    onPressed: () {
                      Pref.instance.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFD32F2F),
                      side: BorderSide(color: Color(0xFFD32F2F)),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontSize: (screenWidth * 0.11) * 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Version 7.5.91 R455',
                  style: TextStyle(
                      color: Colors.grey, fontSize: screenWidth * 0.033),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    String label,{
    VoidCallback? onTap,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: FittedBox(
                    fit: BoxFit.contain, child: Icon(icon, size: 20))),
            SizedBox(height: 20.0),
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.04,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String label,{VoidCallback? onTap}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: screenWidth * 0.06), // Scaled icon size
      title: Text(
        label,
        style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.normal), // Scaled font size
      ),
      trailing: Icon(Icons.arrow_forward_ios,
          size: screenWidth * 0.04), // Scaled icon size
      onTap: onTap,
    );
  }
}

class SkippedAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: screenWidth,
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6200EE),
                  textStyle: TextStyle(fontSize: screenWidth * 0.02),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(
                            requestLogin: true,
                          )));
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: screenHeight * 0.008),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: screenWidth * 0.01),
              leading: Icon(
                FontAwesomeIcons.circleInfo,
                size: screenWidth * 0.07,
                // width: screenWidth * 0.08,
                // height: screenWidth * 0.08,
              ),
              title: Text(
                'About Cleaning Service',
                style: TextStyle(
                    fontSize: screenWidth * 0.045, color: Colors.black87),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[500]),
              onTap: () {
                // Navigate to About UC screen
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'Version 7.5.92 R457',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.001),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



class ProfileScreen extends StatelessWidget {
  final String name = "John Doe";
  final String email = "john.doe@example.com";
  final String phone = "+91 9876543210";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Account", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          _buildProfileHeader(screenWidth),
          Divider(thickness: 1, height: 32),
          _buildListTile(Icons.edit, "Edit Profile", () {
            _showEditProfileSheet(context);
          }),
          // _buildListTile(Icons.security_outlined, "Two-Factor Authentication", () {}),
          _buildListTile(Icons.delete_outline, "Delete Account", () {
            showDeleteAccountSheet(context);
          }),

        ],
      ),
    );
  }

  Widget _buildProfileHeader(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.1,
            backgroundColor: Colors.purple[100],
            child: Icon(Icons.person, color: Colors.purple[700], size: screenWidth * 0.1),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(email, style: TextStyle(color: Colors.grey[700])),
                Text(phone, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }
}




void _showEditProfileSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: EditProfileForm(),
      );
    },
  );
}


class EditProfileForm extends StatefulWidget {
  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "John Doe";
  String email = "john.doe@example.com";
  String phone = "9876543210";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Edit Profile",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Name", name, (val) => name = val),
              _buildTextField("Email", email, (val) => email = val,
                  keyboardType: TextInputType.emailAddress),
              _buildTextField("Phone", phone, (val) => phone = val,
                  keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save logic here
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("Save", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onChanged,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (val) =>
        val == null || val.trim().isEmpty ? 'Required' : null,
        onChanged: onChanged,
      ),
    );
  }
}


void showDeleteAccountSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const DeleteAccountSheet(),
  );
}

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({super.key});

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  bool _isLoading = false;
  String reason = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Please tell us why you’re deleting your account (optional):",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  onChanged: (val) => reason = val,
                  decoration: InputDecoration(
                    hintText: "Enter reason...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _deleteAccount,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Delete My Account", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete your account? This action is irreversible."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    Navigator.pop(context);
    // Navigate to login or home screen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account deleted successfully")),
    );
  }
}
