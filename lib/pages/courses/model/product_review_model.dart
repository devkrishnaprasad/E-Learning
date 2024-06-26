import 'dart:convert';

class ProdcutReviewDetails {
  Response response;

  ProdcutReviewDetails({
    required this.response,
  });

  factory ProdcutReviewDetails.fromRawJson(String str) =>
      ProdcutReviewDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProdcutReviewDetails.fromJson(Map<String, dynamic> json) =>
      ProdcutReviewDetails(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<ProdcutReviewRecord> records;
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
        records: List<ProdcutReviewRecord>.from(
            json["records"].map((x) => ProdcutReviewRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class ProdcutReviewRecord {
  String lastModified;
  String noOfLikes;
  String productId;
  String rating;
  String reviewDescription;
  String reviewId;
  String username;

  ProdcutReviewRecord({
    required this.lastModified,
    required this.noOfLikes,
    required this.productId,
    required this.rating,
    required this.reviewDescription,
    required this.reviewId,
    required this.username,
  });

  factory ProdcutReviewRecord.fromRawJson(String str) =>
      ProdcutReviewRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProdcutReviewRecord.fromJson(Map<String, dynamic> json) =>
      ProdcutReviewRecord(
        lastModified: json["last_modified"],
        noOfLikes: json["no_of_likes"] ?? "NA",
        productId: json["product_id"],
        rating: json["rating"],
        reviewDescription: json["review_description"],
        reviewId: json["review_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "last_modified": lastModified,
        "no_of_likes": noOfLikes,
        "product_id": productId,
        "rating": rating,
        "review_description": reviewDescription,
        "review_id": reviewId,
        "username": username,
      };
}
