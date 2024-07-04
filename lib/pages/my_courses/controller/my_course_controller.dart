import 'dart:developer';

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
  RxBool isLastLevel = false.obs;

  getLevelRecord(productId) async {
    try {
      var payload = {"product_id": productId};
      var response = await myCourseApi.getLevelRecord(payload);
      if (response.isNotEmpty) {
        levelRecord.assignAll(response);

        bool levelFound = false;

        for (int j = 0;
            j < coursesController.courseDetails[0].sessions.length;
            j++) {
          for (int i = 0;
              i < coursesController.courseDetails[0].sessions[j].levels.length;
              i++) {
            bool isPresent = levelRecord.any((course) =>
                course.levelId ==
                coursesController
                    .courseDetails[0].sessions[j].levels[i].levelId);
            if (!isPresent) {
              currentLevelId.value = coursesController
                  .courseDetails[0].sessions[j].levels[i].levelId;
              helperController.currentSessionVideoUrl.value = coursesController
                  .courseDetails[0].sessions[j].levels[i].videoPath;
              levelFound = true;
              if (coursesController
                      .courseDetails[0].sessions[j].levels.length ==
                  i + 1) {
                isLastLevel.value = true;
              } else {
                isLastLevel.value = false;
              }
              break;
            }
          }
          if (levelFound) {
            break;
          }
          checkSessionIsCompleted();
        }
        print("The bool value ${isLastLevel.value}");
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
    try {
      var payload = {
        "product_id":
            coursesController.courseDetails[0].productDetails.productId,
        "session_id": currentSessionId.value
      };
      await myCourseApi.markSessionCompleted(payload);
    } catch (e) {
      log("Error markSessionCompleted $e");
    }
  }

  markLevelCompleted() async {
    try {
      var payload = {
        "product_id":
            coursesController.courseDetails[0].productDetails.productId,
        "session_id": currentSessionId.value,
        "level_id": currentLevelId.value
      };
      log(payload.toString());
      await myCourseApi.markLevelompleted(payload);
    } catch (e) {
      log("Error markLevelCompleted $e");
    }
  }

  checkSessionIsCompleted() {
    print("Current session ${currentSessionId.value}");
    int index = coursesController.courseDetails[0].sessions
        .indexWhere((session) => session.sessionId == currentSessionId.value);
    if (index == -1) {
      log('Session not found');
      return false;
    }
    var levels = coursesController.courseDetails[0].sessions[index].levels;
    bool allLevelsPresent = levels.every((level) =>
        levelRecord.any((record) => record.levelId == level.levelId));

    if (allLevelsPresent) {
      log('All levels are present in the level record');
      markLevelCompleted();
    } else {
      log('Not all levels are present in the level record');
    }
    return allLevelsPresent;
  }
}
