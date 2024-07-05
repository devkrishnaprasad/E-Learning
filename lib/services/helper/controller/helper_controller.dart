import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:e_learn/pages/my_courses/controller/my_course_controller.dart';
import 'package:e_learn/pages/my_courses/model/completed_course_model.dart';
import 'package:e_learn/pages/my_courses/model/purchase_model.dart';
import 'package:e_learn/services/helper/controller/api/helper_api.dart';
import 'package:e_learn/services/helper/local_storage/local_storage.dart';
import 'package:e_learn/services/helper/model/helper_models.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class HelperController extends GetxController {
  HelperApiService helperApiService = HelperApiService();
  LocalStorage localStorage = LocalStorage();
  var allCoursesList = <CoursListRecord>[].obs;
  var allPopularCoursesList = <PopularCoursesListRecord>[].obs;
  var allCourseCategooryList = <CategoryListRecord>[].obs;
  var allBannerList = <BannerListRecord>[].obs;
  var userDetails = <UserDetailsRecord>[].obs;
  var purchaseDetails = <PurchaseRecord>[].obs;
  var completedCourseDetails = <CompletedCourseRecord>[].obs;
  RxString currentSessionVideoUrl = ''.obs;
  RxBool isVideoLoading = false.obs;
  RxBool isLoading = false.obs;
  RxString userFullName = ''.obs;
  var playerWidget = Rxn<Chewie>();
  bool hasCalledApi = false;

  VideoPlayerController? videoPlayerController;
  initialSetup() async {
    var data = await localStorage.readUserToken();
    // ignore: unnecessary_null_comparison
    if (data != null) {
      userFullName.value = await localStorage.read('full_name');
      log('User Loged in ');
      return true;
    } else {
      log("User not loged in");
      return false;
    }
  }

  getAllCoursesList() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getAllCoursesList();
      if (response.isNotEmpty) {
        allCoursesList.assignAll(response);
      } else {
        allCoursesList.assignAll([]);
      }
    } catch (e) {
      log("Error while geting all courses list $e");
    } finally {
      isLoading.value = false;
    }
  }

  getAllPopuplarCoursesList() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getAllPopuplarCoursesList();

      if (response.isNotEmpty) {
        allPopularCoursesList.assignAll(response);
      } else {
        allPopularCoursesList.assignAll([]);
      }
    } catch (e) {
      log("Error while geting all category list $e");
    } finally {
      isLoading.value = false;
    }
  }

  getAllCourseCategoryList() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getAllCourseCategoryList();

      if (response.isNotEmpty) {
        allCourseCategooryList.assignAll(response);
      } else {
        allCourseCategooryList.assignAll([]);
      }
    } catch (e) {
      log("Error while geting all category list $e");
    } finally {
      isLoading.value = false;
    }
  }

  getAllBannersList() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getAllBannersList();

      if (response.isNotEmpty) {
        allBannerList.assignAll(response);
      } else {
        allBannerList.assignAll([]);
      }
    } catch (e) {
      log("Error while geting all banners list $e");
    } finally {
      isLoading.value = false;
    }
  }

  void videoPlayer(String videoUrl, bool isDetailsOnly) async {
    try {
      isVideoLoading.value = true;

      // Dispose the old controller if it exists
      if (videoPlayerController != null) {
        videoPlayerController!.removeListener(_videoListener);
        await videoPlayerController!.dispose();
      }

      // Create and initialize the new controller
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController!.initialize();

      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
      );

      playerWidget.value = Chewie(
        controller: chewieController,
      );
      isVideoLoading.value = false;

      hasCalledApi = false;
      if (!isDetailsOnly) {
        videoPlayerController!.addListener(_videoListener);
      }
    } catch (e) {
      log("Failed to load video $e");
      isVideoLoading.value = false;
    }
  }

  void _videoListener() async {
    MyCourseController myCourseController = Get.find();
    if (videoPlayerController!.value.isInitialized) {
      final duration = videoPlayerController!.value.duration;
      final position = videoPlayerController!.value.position;

      if (position.inSeconds >= (0.9 * duration.inSeconds).round() &&
          !hasCalledApi) {
        hasCalledApi = true;
        await myCourseController.markLevelCompleted();

        await myCourseController.getLevelRecord(myCourseController
            .coursesController.courseDetails[0].productDetails.productId);

        await myCourseController.getSessionRecord(myCourseController
            .coursesController.courseDetails[0].productDetails.productId);
      }

      if (videoPlayerController!.value.isPlaying &&
          position.inSeconds == duration.inSeconds) {
        await callAnotherFunctionWhenCompleted();
      }
    }
  }

  Future<void> callAnotherFunctionWhenCompleted() async {
    // Logic to execute when the video is fully completed
    log("Video playback completed. Calling another function...");
  }

  userSigin(email, password) async {
    try {
      isLoading.value = true;
      var payload = {"email": email, "password": password};
      var response = await helperApiService.signIn(payload);
      if (response.isNotEmpty) {
        userDetails.assignAll(response);
        await localStorage.write('email', email);
        await localStorage.write('password', email);
        await localStorage.write('full_name', userDetails[0].fullName);
        await localStorage.writeUserToken(userDetails[0].userToken);
        userFullName.value = userDetails[0].fullName;
      } else {
        userDetails.assignAll([]);
      }
    } catch (e) {
      log("login error $e");
    } finally {
      isLoading.value = false;
    }
  }

  userRegister(name, email, password) async {
    try {
      isLoading.value = true;
      var payload = {"full_name": name, "email": email, "password": password};
      helperApiService.signUp(payload);
    } catch (e) {
      log("login error $e");
    } finally {
      isLoading.value = false;
    }
  }

  getPurchaseDetails() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getPurchaseDetails();
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

  getCompletedCourseDetails() async {
    isLoading.value = true;
    try {
      var response = await helperApiService.getCompletedCurseDetails();
      if (response.isNotEmpty) {
        completedCourseDetails.assignAll(response);
      } else {
        purchaseDetails.assignAll([]);
      }
    } catch (e) {
      log("Error while getCompletedCourseDetails list $e");
    } finally {
      isLoading.value = false;
    }
  }
}
