import 'dart:developer';
import 'package:e_learn/pages/courses/controller/api/course_api.dart';
import 'package:e_learn/pages/courses/model/product_review_model.dart';
import 'package:e_learn/pages/courses/model/session_details_model.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  CoursesApiService coursesApiService = CoursesApiService();
  var courseDetails = <SessionDetailsRecord>[].obs;
  var productReviewDetails = <ProdcutReviewRecord>[].obs;
  RxBool isLoading = false.obs;

  getCourseDetails(productId) async {
    isLoading.value = true;
    try {
      var response = await coursesApiService.getCourseDetails(productId);
      if (response.isNotEmpty) {
        courseDetails.assignAll(response);
      } else {
        courseDetails.assignAll([]);
      }
    } catch (e) {
      log("Error while getCourseDetails list $e");
    } finally {
      isLoading.value = false;
    }
  }

  getProductReview(productId) async {
    isLoading.value = true;
    try {
      var response = await coursesApiService.getProductReview(productId);
      if (response.isNotEmpty) {
        productReviewDetails.assignAll(response);
      } else {
        productReviewDetails.assignAll([]);
      }
    } catch (e) {
      log("Error while getProductReview list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
