class CategoriesServiceModel {
  CategoriesServiceModel({
    required this.categories,
  }) {
    _categories = categories;
  }

  static List<Category> _categories = [];

  final List<Category> categories;

  static List<Category> get globalCategories => _categories;

  factory CategoriesServiceModel.fromJson(Map<String, dynamic> json){
    return CategoriesServiceModel(
      categories: json["Categories"] == null ? [] : List<Category>.from(json["Categories"]!.map((x) => Category.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "Categories": categories.map((x) => x.toJson()).toList(),
  };

  static Service? getServiceById(int serviceId) {
    for (var category in _categories) {
      for (var subCategory in category.subCategory) {
        for (var service in subCategory.services) {
          if (service.id == serviceId) {
            return service;
          }
        }
      }
    }
    return null;
  }
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.description,
    required this.iconUrl,
    required this.thumbnailUrl,
    required this.subCategory,
  });

  final int id;
  final String categoryName;
  final String description;
  final String iconUrl;
  final String thumbnailUrl;
  final List<SubCategory> subCategory;

  factory Category.fromJson(Map<String, dynamic> json) {
    List<dynamic> subCatJson = json["SubCategory"] ?? [];

    // Filter out SubCategories where Services is not a non-empty List
    List<SubCategory> filteredSubCategories = subCatJson
        .where((item) =>
    item["Services"] is List && item["Services"].isNotEmpty)
        .map<SubCategory>((item) => SubCategory.fromJson(item))
        .toList();

    return Category(
      id: json["id"] ?? 0,
      categoryName: json["CategoryName"] ?? "",
      description: json["Description"] ?? "",
      iconUrl: json["IconURL"] ?? "",
      thumbnailUrl: json["ThumbnailURL"] ?? "",
      subCategory: filteredSubCategories,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "CategoryName": categoryName,
    "Description": description,
    "IconURL": iconUrl,
    "ThumbnailURL": thumbnailUrl,
    "SubCategory": subCategory.map((x) => x.toJson()).toList(),
  };

}

class SubCategory {
  SubCategory({
    required this.id,
    required this.cid,
    required this.subCategoryName,
    required this.description,
    required this.iconUrl,
    required this.thumbnailUrl,
    required this.services,
  });

  final int id;
  final num cid;
  final String subCategoryName;
  final String description;
  final String iconUrl;
  final String thumbnailUrl;
  final List<Service> services;

  factory SubCategory.fromJson(Map<String, dynamic> json){
    return SubCategory(
      id: json["id"] ?? 0,
      cid: json["CID"] ?? 0,
      subCategoryName: json["SubCategoryName"] ?? "",
      description: json["Description"] ?? "",
      iconUrl: json["IconURL"] ?? "",
      thumbnailUrl: json["ThumbnailURL"] ?? "",
      services: json["Services"] == null ? [] : List<Service>.from(json["Services"]!.map((x) => Service.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "CID": cid,
    "SubCategoryName": subCategoryName,
    "Description": description,
    "IconURL": iconUrl,
    "ThumbnailURL": thumbnailUrl,
    "Services": services.map((x) => x.toJson()).toList(),
  };

}

class Service {
  Service({
    required this.id,
    required this.cid,
    required this.sid,
    required this.serviceName,
    required this.description,
    required this.strikePrice,
    required this.price,
    required this.duration,
    required this.iconUrl,
    required this.thumbnailUrl,
    required this.included,
    required this.pleaseNote,
    required this.rating,
    required this.subServices,
    required this.reviews,
  });

  final int id;
  final num cid;
  final num sid;
  final String serviceName;
  final String description;
  final num strikePrice;
  final num price;
  final num duration;
  final String iconUrl;
  final String thumbnailUrl;
  final String included;
  final String pleaseNote;
  final dynamic rating;
  final List<dynamic> subServices;
  final dynamic reviews;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      id: json["id"] ?? 0,
      cid: json["CID"] ?? 0,
      sid: json["SID"] ?? 0,
      serviceName: json["ServiceName"] ?? "",
      description: json["Description"] ?? "",
      strikePrice: json["StrikePrice"] ?? 0,
      price: json["Price"] ?? 0,
      duration: json["Duration"] ?? 0,
      iconUrl: json["IconURL"] ?? "",
      thumbnailUrl: json["ThumbnailURL"] ?? "",
      included: json["Included"] ?? "",
      pleaseNote: json["PleaseNote"] ?? "",
      rating: json["Rating"],
      subServices: json["SubServices"] == null ? [] : List<dynamic>.from(json["SubServices"]!.map((x) => x)),
      reviews: json["Reviews"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "CID": cid,
    "SID": sid,
    "ServiceName": serviceName,
    "Description": description,
    "StrikePrice": strikePrice,
    "Price": price,
    "Duration": duration,
    "IconURL": iconUrl,
    "ThumbnailURL": thumbnailUrl,
    "Included": included,
    "PleaseNote": pleaseNote,
    "Rating": rating,
    "SubServices": subServices.map((x) => x).toList(),
    "Reviews": reviews,
  };

}
