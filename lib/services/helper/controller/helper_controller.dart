import 'dart:developer';
import 'package:chewie/chewie.dart';
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
  RxBool isLoading = false.obs;
  RxString userFullName = ''.obs;
  var playerWidget = Rxn<Chewie>();

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

  videoPlayer(videoUrl) async {
    try {
      final videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      await videoPlayerController.initialize();
      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
      );

      playerWidget.value = Chewie(
        controller: chewieController,
      );
    } catch (e) {
      log("Failed to load video $e");
    }
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
}
