import 'dart:convert';

class SessionDetails {
  Response response;

  SessionDetails({
    required this.response,
  });

  factory SessionDetails.fromRawJson(String str) =>
      SessionDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SessionDetails.fromJson(Map<String, dynamic> json) => SessionDetails(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<SessionDetailsRecord> records;
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
        records: List<SessionDetailsRecord>.from(
            json["records"].map((x) => SessionDetailsRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class SessionDetailsRecord {
  ProductDetails productDetails;
  List<Session> sessions;

  SessionDetailsRecord({
    required this.productDetails,
    required this.sessions,
  });

  factory SessionDetailsRecord.fromRawJson(String str) =>
      SessionDetailsRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SessionDetailsRecord.fromJson(Map<String, dynamic> json) =>
      SessionDetailsRecord(
        productDetails: ProductDetails.fromJson(json["product_details"]),
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_details": productDetails.toJson(),
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class ProductDetails {
  String about;
  String productId;
  String productName;
  String rating;
  String videoUrl;
  String price;
  String offerPrice;
  String totalDuration;
  String sessionCount;

  ProductDetails({
    required this.about,
    required this.productId,
    required this.productName,
    required this.rating,
    required this.videoUrl,
    required this.price,
    required this.offerPrice,
    required this.totalDuration,
    required this.sessionCount,
  });

  factory ProductDetails.fromRawJson(String str) =>
      ProductDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        about: json["about"],
        productId: json["product_id"],
        productName: json["product_name"],
        rating: json["rating"],
        videoUrl: json['video_url'],
        price: json['price'],
        offerPrice: json['offer_price'],
        totalDuration: json['total_duration'],
        sessionCount: json['session_count'],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "product_id": productId,
        "product_name": productName,
        "rating": rating,
        "video_url": videoUrl,
        "price": price,
        "offer_price": offerPrice,
        "total_duration": totalDuration,
        "session_count": sessionCount,
      };
}

class Session {
  List<Level> levels;
  String sessionDuration;
  String sessionId;
  String sessionTitle;

  Session({
    required this.levels,
    required this.sessionDuration,
    required this.sessionId,
    required this.sessionTitle,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        levels: List<Level>.from(json["levels"].map((x) => Level.fromJson(x))),
        sessionDuration: json["session_duration"],
        sessionId: json["session_id"],
        sessionTitle: json["session_title"],
      );

  Map<String, dynamic> toJson() => {
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
        "session_duration": sessionDuration,
        "session_id": sessionId,
        "session_title": sessionTitle,
      };
}

class Level {
  String duration;
  String levelId;
  String levelTitle;
  String resourses;
  String videoPath;

  Level({
    required this.duration,
    required this.levelId,
    required this.levelTitle,
    required this.resourses,
    required this.videoPath,
  });

  factory Level.fromRawJson(String str) => Level.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        duration: json["duration"],
        levelId: json["level_id"],
        levelTitle: json["level_title"],
        resourses: json["resourses"],
        videoPath: json["video_path"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "level_id": levelId,
        "level_title": levelTitle,
        "resourses": resourses,
        "video_path": videoPath,
      };
}
