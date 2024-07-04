import 'package:e_learn/pages/home/view/home.dart';
import 'package:e_learn/pages/inbox/view/inbox.dart';
import 'package:e_learn/pages/my_courses/view/my_courses.dart';
import 'package:e_learn/pages/profile/profile.dart';
import 'package:e_learn/pages/transcation/view/transcation.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  HelperController helperController = Get.find();
  @override
  void onInit() {
    super.onInit();
    helperController.getAllCoursesList();
    helperController.getAllCourseCategoryList();
    helperController.getAllPopuplarCoursesList();
    helperController.getAllBannersList();
    helperController.getPurchaseDetails();
  }

  final List<Widget> children = [
    HomePage(),
    MyCourses(),
    Inbox(),
    const Transcation(),
    const Profile(),
  ];

  RxInt currentIndex = 0.obs;
}
