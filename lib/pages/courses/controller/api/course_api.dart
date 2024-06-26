import 'dart:developer';

import 'package:e_learn/pages/courses/model/product_review_model.dart';
import 'package:e_learn/pages/courses/model/session_details_model.dart';
import 'package:e_learn/services/api/api_provider.dart';
import 'package:e_learn/services/api/constants.dart';

class CoursesApiService {
  ApiProvider apiProvider = ApiProvider();

  Future<List<SessionDetailsRecord>> getCourseDetails(productId) async {
    List<SessionDetailsRecord> courseDatils = [];

    try {
      var payload = {"product_id": productId};
      var response =
          await apiProvider.postRequest(getSessionApiEndpoint, payload);
      courseDatils = response
          .map<SessionDetailsRecord>((p) => SessionDetailsRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return courseDatils;
      }
    } catch (e) {
      log("Error while getCourseDetails : $e");
      return [];
    }
    return [];
  }

  Future<List<ProdcutReviewRecord>> getProductReview(productId) async {
    List<ProdcutReviewRecord> reviewDetails = [];

    try {
      var payload = {"product_id": productId};
      var response =
          await apiProvider.postRequest(getProductReviewEndpoint, payload);
      reviewDetails = response
          .map<ProdcutReviewRecord>((p) => ProdcutReviewRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return reviewDetails;
      }
    } catch (e) {
      log("Error while getCourseDetails : $e");
      return [];
    }
    return [];
  }
}
