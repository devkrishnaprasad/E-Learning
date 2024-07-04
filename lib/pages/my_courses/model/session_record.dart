import 'dart:convert';

class SessionResponse {
  Response response;

  SessionResponse({
    required this.response,
  });

  factory SessionResponse.fromRawJson(String str) =>
      SessionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SessionResponse.fromJson(Map<String, dynamic> json) =>
      SessionResponse(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<SessionRecord> records;
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
        records: List<SessionRecord>.from(
            json["records"].map((x) => SessionRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class SessionRecord {
  String dateOfCompletion;
  String productId;
  String sessionId;
  bool status;
  String username;

  SessionRecord({
    required this.dateOfCompletion,
    required this.productId,
    required this.sessionId,
    required this.status,
    required this.username,
  });

  factory SessionRecord.fromRawJson(String str) =>
      SessionRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SessionRecord.fromJson(Map<String, dynamic> json) => SessionRecord(
        dateOfCompletion: json["date_of_completion"],
        productId: json["product_id"],
        sessionId: json["session_id"],
        status: json["status"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_completion": dateOfCompletion,
        "product_id": productId,
        "session_id": sessionId,
        "status": status,
        "username": username,
      };
}
