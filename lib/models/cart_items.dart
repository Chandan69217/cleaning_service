import 'package:intl/intl.dart';

class CartItems {
  CartItems({
    required this.data,
  });

  final List<Datum> data;

  factory CartItems.fromJson(Map<String, dynamic> json){
    return CartItems(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };

}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
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

