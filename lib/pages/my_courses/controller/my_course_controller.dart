import 'dart:developer';

import 'package:e_learn/pages/certificate/certificate.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/my_courses/controller/api/my_course_api.dart';
import 'package:e_learn/pages/my_courses/model/level_record.dart';
import 'package:e_learn/pages/my_courses/model/session_record.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:get/get.dart';

class MyCourseController extends GetxController {
  RxBool isLoading = false.obs;
  MyCourseApi myCourseApi = MyCourseApi();
  var levelRecord = <LevelRecord>[].obs;
  var sessionRecord = <SessionRecord>[].obs;
  CoursesController coursesController = Get.find();
  HelperController helperController = Get.find();
  RxString currentSessionId = ''.obs;
  RxString currentLevelId = ''.obs;

  getLevelRecord(productId) async {
    try {
      var payload = {"product_id": productId};
      var response = await myCourseApi.getLevelRecord(payload);
      if (response.isNotEmpty) {
        levelRecord.assignAll(response);
        getCurrentLevel();
      } else {
        levelRecord.assignAll([]);
        currentLevelId.value =
            coursesController.courseDetails[0].sessions[0].levels[0].levelId;
      }
    } catch (e) {
      log('failed to fetch level records $e');
    }
  }

  getSessionRecord(productId) async {
    try {
      var payload = {"product_id": productId};
      var response = await myCourseApi.getSessionRecord(payload);
      if (response.isNotEmpty) {
        sessionRecord.assignAll(response);
        getCurrentSession();
      } else {
        levelRecord.assignAll([]);
        currentSessionId.value =
            coursesController.courseDetails[0].sessions[0].sessionId;
      }
    } catch (e) {
      log('failed to fetch session records $e');
    }
  }

  markSessionCompleted() async {
    var status = sessionRecord
        .any((element) => element.sessionId == currentSessionId.value);
    if (!status) {
      try {
        var payload = {
          "product_id":
              coursesController.courseDetails[0].productDetails.productId,
          "session_id": currentSessionId.value
        };
        await myCourseApi.markSessionCompleted(payload);
        await markCourseCompleted();
      } catch (e) {
        log("Error markSessionCompleted $e");
      }
    } else {
      log('Session alredy completed');
    }
  }

  markLevelCompleted() async {
    try {
      var status =
          levelRecord.any((element) => element.levelId == currentLevelId.value);
      if (!status) {
        var payload = {
          "product_id":
              coursesController.courseDetails[0].productDetails.productId,
          "session_id": currentSessionId.value,
          "level_id": currentLevelId.value
        };
        await myCourseApi.markLevelompleted(payload);
      } else {
        log('Level is alredy completed');
      }
    } catch (e) {
      log("Error markLevelCompleted $e");
    }
  }

  markCourseCompleted() async {
    var isCompleted = helperController.completedCourseDetails.any((element) =>
        element.productId ==
        coursesController.courseDetails[0].productDetails.productId);
    bool isSessionCompleted = false;

    for (int i = 0; i < sessionRecord.length; i++) {
      isSessionCompleted = sessionRecord
          .any((element) => element.sessionId == sessionRecord[i].sessionId);
    }
    if (!isCompleted && isSessionCompleted) {
      try {
        var payload = {
          "product_id":
              coursesController.courseDetails[0].productDetails.productId,
        };
        await myCourseApi.markCourseompleted(payload);
        await helperController.getCompletedCourseDetails();

        Get.to(CertificatePage(
          courseName: helperController.userDetails[0].fullName,
          username: helperController.userDetails[0].fullName,
        ));
      } catch (e) {
        log("Error markCourseCompleted $e");
      }
    }
  }

  getCurrentLevel() {
    bool levelFound = false;
    for (int j = 0;
        j < coursesController.courseDetails[0].sessions.length;
        j++) {
      for (int i = 0;
          i < coursesController.courseDetails[0].sessions[j].levels.length;
          i++) {
        bool isPresent = levelRecord.any((course) =>
            course.levelId ==
            coursesController.courseDetails[0].sessions[j].levels[i].levelId);
        if (!isPresent) {
          currentLevelId.value =
              coursesController.courseDetails[0].sessions[j].levels[i].levelId;
          helperController.currentSessionVideoUrl.value = coursesController
              .courseDetails[0].sessions[j].levels[i].videoPath;
          levelFound = true;

          break;
        }
      }
      if (levelFound) {
        break;
      }
    }

    var status = checkAllLevelCompleted();
    if (status) {
      markSessionCompleted();
    }
  }

  getCurrentSession() {
    for (int i = 0;
        i < coursesController.courseDetails[0].sessions.length;
        i++) {
      bool isPresent = sessionRecord.any((course) =>
          course.sessionId ==
          coursesController.courseDetails[0].sessions[i].sessionId);

      if (!isPresent) {
        currentSessionId.value =
            coursesController.courseDetails[0].sessions[i].sessionId;
        break;
      }
    }
  }

  checkAllLevelCompleted() {
    var index = coursesController.courseDetails[0].sessions
        .indexWhere((element) => element.sessionId == currentSessionId.value);

    if (index == -1) {
      return false;
    }
    for (int i = 0;
        i < coursesController.courseDetails[0].sessions[index].levels.length;
        i++) {
      var status = levelRecord.any((element) =>
          element.levelId ==
          coursesController.courseDetails[0].sessions[index].levels[i].levelId);

      if (!status) {
        return false;
      }
    }
    return true;

    // 74cd343a-98b9-4b15-92ec-b825c8e44ce2
  }
}
