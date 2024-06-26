import 'dart:developer';

import 'package:e_learn/pages/main/navigation_page.dart';
import 'package:e_learn/pages/signin_sigin_up/signin_page.dart';
import 'package:e_learn/services/api/api_provider.dart';
import 'package:e_learn/services/api/constants.dart';
import 'package:e_learn/services/helper/model/helper_models.dart';
import 'package:e_learn/utils/snackbar/snackbar.dart';
import 'package:get/get.dart';

class HelperApiService {
  ApiProvider apiProvider = ApiProvider();
  Future<List<CoursListRecord>> getAllCoursesList() async {
    List<CoursListRecord> allCourses = [];

    try {
      var response = await apiProvider.getRequest(allCoursesApiEndpoint);
      allCourses = response
          .map<CoursListRecord>((p) => CoursListRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return allCourses;
      }
    } catch (e) {
      log("Error while getAllCoursesList : $e");
      return [];
    }
    return [];
  }

  Future<List<PopularCoursesListRecord>> getAllPopuplarCoursesList() async {
    List<PopularCoursesListRecord> allPopuplarCourses = [];

    try {
      var response = await apiProvider.getRequest(allPopularCoursesApiEndpoint);
      allPopuplarCourses = response
          .map<PopularCoursesListRecord>(
              (p) => PopularCoursesListRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return allPopuplarCourses;
      }
    } catch (e) {
      log("Error while getAllCoursesList : $e");
      return [];
    }
    return [];
  }

  Future<List<CategoryListRecord>> getAllCourseCategoryList() async {
    List<CategoryListRecord> categoryList = [];

    try {
      var response = await apiProvider.getRequest(allCategoryApiEndpoint);
      categoryList = response
          .map<CategoryListRecord>((p) => CategoryListRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return categoryList;
      }
    } catch (e) {
      log("Error while getAllCourseCategoryList : $e");
      return [];
    }
    return [];
  }

  Future<List<BannerListRecord>> getAllBannersList() async {
    List<BannerListRecord> bannerList = [];

    try {
      var response = await apiProvider.getRequest(allBannersApiEndpoint);
      bannerList = response
          .map<BannerListRecord>((p) => BannerListRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return bannerList;
      }
    } catch (e) {
      log("Error while getAllBannersList : $e");
      return [];
    }
    return [];
  }

  signUp(payload) async {
    try {
      apiProvider.postRequest(userSignupEndpoint, payload);
      Get.to(SignInPage());
      SnackbarHelper.showSnackbar(
          type: 'Success',
          message: "Sign up success please sign in using email and password");
    } catch (e) {
      log("Error while register new user");
    }
  }

  Future<List<UserDetailsRecord>> signIn(payload) async {
    List<UserDetailsRecord> allCourses = [];

    try {
      var response = await apiProvider.postRequest(userSiginEndpoint, payload);
      allCourses = response
          .map<UserDetailsRecord>((p) => UserDetailsRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        SnackbarHelper.showSnackbar(type: 'Success', message: 'Login Success');
        Get.to(NavigationPage());
        return allCourses;
      }
    } catch (e) {
      log("Error to login : $e");
      return [];
    }
    return [];
  }
}
