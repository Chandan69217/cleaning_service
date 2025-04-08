import 'package:intl/intl.dart';

class BookedServiceList {
  BookedServiceList({
    required this.bookingsList,
  });

  final List<BookedService> bookingsList;

  factory BookedServiceList.fromJson(Map<String, dynamic> json){
    return BookedServiceList(
      bookingsList: json["data"] == null ? [] : List<BookedService>.from(json["data"]!.map((x) => BookedService.fromJson(x))).reversed.toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": bookingsList.map((x) => x.toJson()).toList().reversed.toList(),
  };

}

class BookedService {
  BookedService({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.qty,
    required this.price,
    required this.serviceName,
    required this.image,
    required this.edate,
    required this.status
  }){
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
  String status;

  factory BookedService.fromJson(Map<String, dynamic> json){
    return BookedService(
      id: json["Id"] ?? 0,
      userId: json["UserId"] ?? 0,
      serviceId: json["ServiceId"] ?? 0,
      qty: json["Qty"] ?? 0,
      price: json["Price"] ?? 0,
      serviceName: json["ServiceName"] ?? "",
      image: json["Image"] ?? "",
      edate: DateTime.tryParse(json["Edate"] ?? ""),
      status: json['Sts']??'N/A'
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
    "Sts" : status
  };

  String _formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy - hh:mm a").format(date);
  }
}
