import 'dart:convert';

class AllCoursList {
  CoursListResponse response;

  AllCoursList({
    required this.response,
  });

  factory AllCoursList.fromRawJson(String str) =>
      AllCoursList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCoursList.fromJson(Map<String, dynamic> json) => AllCoursList(
        response: CoursListResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class CoursListResponse {
  String msg;
  List<CoursListRecord> records;
  bool status;

  CoursListResponse({
    required this.msg,
    required this.records,
    required this.status,
  });

  factory CoursListResponse.fromRawJson(String str) =>
      CoursListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoursListResponse.fromJson(Map<String, dynamic> json) =>
      CoursListResponse(
        msg: json["msg"],
        records: List<CoursListRecord>.from(
            json["records"].map((x) => CoursListRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class CoursListRecord {
  String about;
  String lastModified;
  String offerPrice;
  String productCategory;
  String productId;
  String productImage;
  String productLevel;
  String productName;
  String rating;
  String sessionCount;
  bool status;
  String studentsCount;
  String totalDuration;
  String username;
  String price;

  CoursListRecord({
    required this.price,
    required this.about,
    required this.lastModified,
    required this.offerPrice,
    required this.productCategory,
    required this.productId,
    required this.productImage,
    required this.productLevel,
    required this.productName,
    required this.rating,
    required this.sessionCount,
    required this.status,
    required this.studentsCount,
    required this.totalDuration,
    required this.username,
  });

  factory CoursListRecord.fromRawJson(String str) =>
      CoursListRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoursListRecord.fromJson(Map<String, dynamic> json) =>
      CoursListRecord(
          about: json["about"],
          lastModified: json["last_modified"],
          offerPrice: json["offer_price"],
          productCategory: json["product_category"],
          productId: json["product_id"],
          productImage: json["product_image"],
          productLevel: json["product_level"],
          productName: json["product_name"],
          rating: json["rating"],
          sessionCount: json["session_count"],
          status: json["status"],
          studentsCount: json["students_count"],
          totalDuration: json["total_duration"],
          username: json["username"],
          price: json["price"]);

  Map<String, dynamic> toJson() => {
        "about": about,
        "last_modified": lastModified,
        "offer_price": offerPrice,
        "product_category": productCategory,
        "product_id": productId,
        "product_image": productImage,
        "product_level": productLevel,
        "product_name": productName,
        "rating": rating,
        "session_count": sessionCount,
        "status": status,
        "students_count": studentsCount,
        "total_duration": totalDuration,
        "username": username,
        "price": price
      };
}

class AllCategoryList {
  CategoryListResponse response;

  AllCategoryList({
    required this.response,
  });

  factory AllCategoryList.fromRawJson(String str) =>
      AllCategoryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCategoryList.fromJson(Map<String, dynamic> json) =>
      AllCategoryList(
        response: CategoryListResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class CategoryListResponse {
  String msg;
  List<CategoryListRecord> records;
  bool status;

  CategoryListResponse({
    required this.msg,
    required this.records,
    required this.status,
  });

  factory CategoryListResponse.fromRawJson(String str) =>
      CategoryListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      CategoryListResponse(
        msg: json["msg"],
        records: List<CategoryListRecord>.from(
            json["records"].map((x) => CategoryListRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class CategoryListRecord {
  String categoryId;
  String categoryImage;
  String categoryName;
  String lastModified;
  String lastModifiedUser;
  bool status;

  CategoryListRecord({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryName,
    required this.lastModified,
    required this.lastModifiedUser,
    required this.status,
  });

  factory CategoryListRecord.fromRawJson(String str) =>
      CategoryListRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryListRecord.fromJson(Map<String, dynamic> json) =>
      CategoryListRecord(
        categoryId: json["category_id"],
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        lastModified: json["last_modified"],
        lastModifiedUser: json["username"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_image": categoryImage,
        "category_name": categoryName,
        "last_modified": lastModified,
        "last_modified_user": lastModifiedUser,
        "status": status,
      };
}

class PopularCoursesList {
  Response response;

  PopularCoursesList({
    required this.response,
  });

  factory PopularCoursesList.fromRawJson(String str) =>
      PopularCoursesList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularCoursesList.fromJson(Map<String, dynamic> json) =>
      PopularCoursesList(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  String msg;
  List<PopularCoursesListRecord> records;
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
        records: List<PopularCoursesListRecord>.from(
            json["records"].map((x) => PopularCoursesListRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class PopularCoursesListRecord {
  String about;
  String lastModified;
  String offerPrice;
  String price;
  String productCategory;
  String productId;
  String productImage;
  String productLevel;
  String productName;
  String rating;
  String sessionCount;
  bool status;
  String studentsCount;
  String totalDuration;
  String username;

  PopularCoursesListRecord({
    required this.about,
    required this.lastModified,
    required this.offerPrice,
    required this.price,
    required this.productCategory,
    required this.productId,
    required this.productImage,
    required this.productLevel,
    required this.productName,
    required this.rating,
    required this.sessionCount,
    required this.status,
    required this.studentsCount,
    required this.totalDuration,
    required this.username,
  });

  factory PopularCoursesListRecord.fromRawJson(String str) =>
      PopularCoursesListRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularCoursesListRecord.fromJson(Map<String, dynamic> json) =>
      PopularCoursesListRecord(
        about: json["about"],
        lastModified: json["last_modified"],
        offerPrice: json["offer_price"],
        price: json["price"],
        productCategory: json["product_category"],
        productId: json["product_id"],
        productImage: json["product_image"],
        productLevel: json["product_level"],
        productName: json["product_name"],
        rating: json["rating"],
        sessionCount: json["session_count"],
        status: json["status"],
        studentsCount: json["students_count"],
        totalDuration: json["total_duration"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "about": about,
        "last_modified": lastModified,
        "offer_price": offerPrice,
        "price": price,
        "product_category": productCategory,
        "product_id": productId,
        "product_image": productImage,
        "product_level": productLevel,
        "product_name": productName,
        "rating": rating,
        "session_count": sessionCount,
        "status": status,
        "students_count": studentsCount,
        "total_duration": totalDuration,
        "username": username,
      };
}

class BannerList {
  Response response;

  BannerList({
    required this.response,
  });

  factory BannerList.fromRawJson(String str) =>
      BannerList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class BannerListResponse {
  String msg;
  List<BannerListRecord> records;
  bool status;

  BannerListResponse({
    required this.msg,
    required this.records,
    required this.status,
  });

  factory BannerListResponse.fromRawJson(String str) =>
      BannerListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerListResponse.fromJson(Map<String, dynamic> json) =>
      BannerListResponse(
        msg: json["msg"],
        records: List<BannerListRecord>.from(
            json["records"].map((x) => BannerListRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class BannerListRecord {
  String amount;
  String bannerId;
  String bannerImage;
  String description;
  String modifiedDate;
  String modifiedUser;
  bool status;
  String title;

  BannerListRecord({
    required this.amount,
    required this.bannerId,
    required this.bannerImage,
    required this.description,
    required this.modifiedDate,
    required this.modifiedUser,
    required this.status,
    required this.title,
  });

  factory BannerListRecord.fromRawJson(String str) =>
      BannerListRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerListRecord.fromJson(Map<String, dynamic> json) =>
      BannerListRecord(
        amount: json["amount"],
        bannerId: json["banner_id"],
        bannerImage: json["banner_image"],
        description: json["description"],
        modifiedDate: json["modified_date"],
        modifiedUser: json["modified_user"],
        status: json["status"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "banner_id": bannerId,
        "banner_image": bannerImage,
        "description": description,
        "modified_date": modifiedDate,
        "modified_user": modifiedUser,
        "status": status,
        "title": title,
      };
}

class UserDetails {
  Response response;

  UserDetails({
    required this.response,
  });

  factory UserDetails.fromRawJson(String str) =>
      UserDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class UserDetailsResponse {
  String msg;
  List<UserDetailsRecord> records;
  bool status;

  UserDetailsResponse({
    required this.msg,
    required this.records,
    required this.status,
  });

  factory UserDetailsResponse.fromRawJson(String str) =>
      UserDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponse(
        msg: json["msg"],
        records: List<UserDetailsRecord>.from(
            json["records"].map((x) => UserDetailsRecord.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
        "status": status,
      };
}

class UserDetailsRecord {
  String createdAt;
  dynamic dateOfBirth;
  String email;
  String fullName;
  dynamic gender;
  bool isActive;
  dynamic lastLogin;
  dynamic phoneNumber;
  dynamic profileImage;
  String updatedAt;
  dynamic userType;
  String userToken;

  UserDetailsRecord(
      {required this.createdAt,
      required this.dateOfBirth,
      required this.email,
      required this.fullName,
      required this.gender,
      required this.isActive,
      required this.lastLogin,
      required this.phoneNumber,
      required this.profileImage,
      required this.updatedAt,
      required this.userType,
      required this.userToken});

  factory UserDetailsRecord.fromRawJson(String str) =>
      UserDetailsRecord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetailsRecord.fromJson(Map<String, dynamic> json) =>
      UserDetailsRecord(
          createdAt: json["created_at"],
          dateOfBirth: json["date_of_birth"],
          email: json["email"],
          fullName: json["full_name"],
          gender: json["gender"],
          isActive: json["is_active"],
          lastLogin: json["last_login"],
          phoneNumber: json["phone_number"],
          profileImage: json["profile_image"],
          updatedAt: json["updated_at"],
          userType: json["user_type"],
          userToken: json["user_token"]);

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "date_of_birth": dateOfBirth,
        "email": email,
        "full_name": fullName,
        "gender": gender,
        "is_active": isActive,
        "last_login": lastLogin,
        "phone_number": phoneNumber,
        "profile_image": profileImage,
        "updated_at": updatedAt,
        "user_type": userType,
        "user_token": userToken
      };
}
