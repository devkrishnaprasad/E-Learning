import 'dart:convert';

class PurchaseDetails {
  Response response;

  PurchaseDetails({
    required this.response,
  });

  factory PurchaseDetails.fromRawJson(String str) =>
      PurchaseDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseDetails.fromJson(Map<String, dynamic> json) =>
      PurchaseDetails(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<PurchaseRecord> records;
  bool status;

  Response({
    required this.msg,
    required this.records,
    required this.status,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        msg: json["msg"],
        records: List<PurchaseRecord>.from(
            json["records"].map((x) => PurchaseRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class PurchaseRecord {
  String paymentMethod;
  String productCategory;
  String productId;
  String productImage;
  String productLevel;
  String productName;
  String purchaseId;
  String purchasedDate;
  String purchasedPrice;
  String rating;
  String sessionCount;
  String totalDuration;
  String username;
  String about;

  PurchaseRecord({
    required this.paymentMethod,
    required this.productCategory,
    required this.productId,
    required this.productImage,
    required this.productLevel,
    required this.productName,
    required this.purchaseId,
    required this.purchasedDate,
    required this.purchasedPrice,
    required this.rating,
    required this.sessionCount,
    required this.totalDuration,
    required this.username,
    required this.about,
  });

  factory PurchaseRecord.fromRawJson(String str) =>
      PurchaseRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurchaseRecord.fromJson(Map<String, dynamic> json) => PurchaseRecord(
      paymentMethod: json["payment_method"],
      productCategory: json["product_category"],
      productId: json["product_id"],
      productImage: json["product_image"],
      productLevel: json["product_level"],
      productName: json["product_name"],
      purchaseId: json["purchase_id"],
      purchasedDate: json["purchased_date"],
      purchasedPrice: json["purchased_price"],
      rating: json["rating"],
      sessionCount: json["session_count"],
      totalDuration: json["total_duration"],
      username: json["username"],
      about: json["about"]);

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "product_category": productCategory,
        "product_id": productId,
        "product_image": productImage,
        "product_level": productLevel,
        "product_name": productName,
        "purchase_id": purchaseId,
        "purchased_date": purchasedDate,
        "purchased_price": purchasedPrice,
        "rating": rating,
        "session_count": sessionCount,
        "total_duration": totalDuration,
        "username": username,
        "about": about
      };
}
