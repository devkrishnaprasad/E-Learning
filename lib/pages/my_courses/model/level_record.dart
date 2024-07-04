import 'dart:convert';

class LevelsResponse {
  Response response;

  LevelsResponse({
    required this.response,
  });

  factory LevelsResponse.fromRawJson(String str) =>
      LevelsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LevelsResponse.fromJson(Map<String, dynamic> json) => LevelsResponse(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<LevelRecord> records;
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
        records: List<LevelRecord>.from(
            json["records"].map((x) => LevelRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class LevelRecord {
  String dateOfCompletion;
  String levelId;
  String productId;
  String sessionId;
  bool status;
  String username;

  LevelRecord({
    required this.dateOfCompletion,
    required this.levelId,
    required this.productId,
    required this.sessionId,
    required this.status,
    required this.username,
  });

  factory LevelRecord.fromRawJson(String str) =>
      LevelRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LevelRecord.fromJson(Map<String, dynamic> json) => LevelRecord(
        dateOfCompletion: json["date_of_completion"],
        levelId: json["level_id"],
        productId: json["product_id"],
        sessionId: json["session_id"],
        status: json["status"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "date_of_completion": dateOfCompletion,
        "level_id": levelId,
        "product_id": productId,
        "session_id": sessionId,
        "status": status,
        "username": username,
      };
}
