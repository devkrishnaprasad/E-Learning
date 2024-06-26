import 'dart:developer';

import 'package:e_learn/pages/my_courses/controller/api/my_course_api.dart';
import 'package:e_learn/pages/my_courses/model/purchase_model.dart';
import 'package:get/get.dart';

class MyCourseController extends GetxController {
  var purchaseDetails = <PurchaseRecord>[].obs;
  RxBool isLoading = false.obs;
  MyCourseApi myCourseApi = MyCourseApi();

  @override
  void onInit() {
    super.onInit();
    if (purchaseDetails.isEmpty) {
      getPurchaseDetails();
    }
  }

  getPurchaseDetails() async {
    isLoading.value = true;
    try {
      var response = await myCourseApi.getPurchaseDetails();
      if (response.isNotEmpty) {
        purchaseDetails.assignAll(response);
      } else {
        purchaseDetails.assignAll([]);
      }
    } catch (e) {
      log("Error while getPurchaseDetails list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
