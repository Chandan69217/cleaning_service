import 'package:intl/intl.dart';

class CartItemsList {

  CartItemsList({
    required this.data,
  }){
    _cartItems = data;
    itemQty = {};
    cartIdByServiceId = {};
    for (var cartItem in data) {
      itemQty.putIfAbsent(cartItem.serviceId.toInt(), () => cartItem.qty);
      cartIdByServiceId.putIfAbsent(cartItem.serviceId.toInt(), () => cartItem.id);
    }
  }

  final List<CartItems> data;
  static List<CartItems> _cartItems = [];
  // static List<CartItems> get globalCartItems => _cartItems;
  static Map<int,dynamic> itemQty = {};
  static Map<int,dynamic> cartIdByServiceId = {};
  factory CartItemsList.fromJson(Map<String, dynamic> json){
    return CartItemsList(
      data: json["data"] == null ? [] : List<CartItems>.from(json["data"]!.map((x) => CartItems.fromJson(x))).reversed.toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class CartItems {
  CartItems({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.qty,
    required this.price,
    required this.serviceName,
    required this.image,
    required this.edate,
  }) {
    if (edate != null) {
      formatDate = _formatDate(edate!);
    } else {
      formatDate = null;
    }
  }

  final num id;
  final num userId;
  final num serviceId;
  final num qty;
  final num price;
  final String serviceName;
  final String image;
  final DateTime? edate;
  String? formatDate;

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      id: json["Id"] ?? 0,
      userId: json["UserId"] ?? 0,
      serviceId: json["ServiceId"] ?? 0,
      qty: json["Qty"] ?? 0,
      price: json["Price"] ?? 0,
      serviceName: json["ServiceName"] ?? "",
      image: json["Image"] ?? "",
      edate: DateTime.tryParse(json["Edate"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "Id": id,
    "UserId": userId,
    "ServiceId": serviceId,
    "Qty": qty,
    "Price": price,
    "ServiceName": serviceName,
    "Image": image,
    "Edate": edate?.toIso8601String(),
  };

  String _formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy - hh:mm a").format(date);
  }
}

