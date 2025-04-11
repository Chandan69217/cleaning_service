class UserDetails {
  UserDetails({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.profileImageUrl,
    required this.sts,
    required this.edate,
  });

  final int id;
  final String fullName;
  final String email;
  final String mobile;
  final String password;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String profileImageUrl;
  final String sts;
  final DateTime? edate;

  factory UserDetails.fromJson(Map<String, dynamic> json){
    return UserDetails(
      id: json["id"] ?? 0,
      fullName: json["FullName"] ?? "",
      email: json["Email"] ?? "",
      mobile: json["Mobile"] ?? "",
      password: json["Password"] ?? "",
      address: json["Address"] ?? "",
      city: json["City"] ?? "",
      state: json["State"] ?? "",
      pincode: json["Pincode"] ?? "",
      profileImageUrl: json["ProfileImageURL"] ?? "",
      sts: json["Sts"] ?? "",
      edate: DateTime.tryParse(json["Edate"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "FullName": fullName,
    "Email": email,
    "Mobile": mobile,
    "Password": password,
    "Address": address,
    "City": city,
    "State": state,
    "Pincode": pincode,
    "ProfileImageURL": profileImageUrl,
    "Sts": sts,
    "Edate": edate?.toIso8601String(),
  };

}
