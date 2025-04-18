class Urls {
  static const String base_url = 'kycapp.atharvaservices.com';
  static const String send_otp = '/api/Auth/send-otp';
  static const String verify_otp = '/api/Auth/verify-otp';
  static const String register = '/api/Auth/register';
  static const String categories = '/api/HomePage/api/homepage';
  static const String addToCart = '/api/Booking/addtocart';
   static const String getCart = '/api/Booking/cart';
  static const String removeCartItem = '/api/Booking/removecartqty';
  static const String getShippingAddress = '/api/Shipping/shippingaddress';
  static const String getShippingAddressById = '/api/Shipping/getshippingaddressbyid';
  static const String addShippingAddress = '/api/Shipping/createshippingaddress';
  static const String getBookingList = '/api/Booking/bookingservicelist';
  static const String getBookingDetailsById = '/api/Booking/bookingdetailsbyid';
  static const String cancelBookingById = '/api/Booking/cancelbookingbyid';
  static const String createBooking = '/api/Booking/createbooking';
  static const String updateCartQty = '/api/Booking/updatecartqty';
  static const String isValidToken = '/api/Auth/isValidToken';
  static const String profileDetails = '/api/Users/profiledetails';
  static const String editProfile = '/api/Users/editprofile';
  static const String getServiceById = '/api/Service/servicebyid';
}

