import 'dart:convert';

class CompletedCourseResponse {
  Response response;

  CompletedCourseResponse({
    required this.response,
  });

  factory CompletedCourseResponse.fromRawJson(String str) =>
      CompletedCourseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompletedCourseResponse.fromJson(Map<String, dynamic> json) =>
      CompletedCourseResponse(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<CompletedCourseRecord> records;
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
        records: List<CompletedCourseRecord>.from(
            json["records"].map((x) => CompletedCourseRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class CompletedCourseRecord {
  String completionDate;
  String itemId;
  String productId;
  String username;

  CompletedCourseRecord({
    required this.completionDate,
    required this.itemId,
    required this.productId,
    required this.username,
  });

  factory CompletedCourseRecord.fromRawJson(String str) =>
      CompletedCourseRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompletedCourseRecord.fromJson(Map<String, dynamic> json) =>
      CompletedCourseRecord(
        completionDate: json["completion_date"],
        itemId: json["item_id"],
        productId: json["product_id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "completion_date": completionDate,
        "item_id": itemId,
        "product_id": productId,
        "username": username,
      };
}
