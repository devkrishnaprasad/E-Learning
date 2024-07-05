import 'dart:developer';
import 'package:e_learn/pages/my_courses/model/level_record.dart';
import 'package:e_learn/pages/my_courses/model/session_record.dart';
import 'package:e_learn/services/api/api_provider.dart';
import 'package:e_learn/services/api/constants.dart';

class MyCourseApi {
  ApiProvider apiProvider = ApiProvider();
  Future<List<LevelRecord>> getLevelRecord(payload) async {
    List<LevelRecord> levelRecord = [];
    try {
      var response =
          await apiProvider.postSecure(getLevelRecordEndpoint, payload);
      levelRecord = response['response']['records']
          .map<LevelRecord>((p) => LevelRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return levelRecord;
      }
    } catch (e) {
      log("Error while getLevelRecord : $e");
      return [];
    }
    return [];
  }

  Future<List<SessionRecord>> getSessionRecord(payload) async {
    List<SessionRecord> levelRecord = [];
    try {
      var response =
          await apiProvider.postSecure(getSessionRecordEndpoint, payload);
      levelRecord = response['response']['records']
          .map<SessionRecord>((p) => SessionRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return levelRecord;
      }
    } catch (e) {
      log("Error while getSessionRecord : $e");
      return [];
    }
    return [];
  }

  markSessionCompleted(payload) async {
    try {
      var response =
          await apiProvider.postSecure(markSessionCompletedEndpoint, payload);
      log("Api response session mark $response");
    } catch (e) {
      log("Error marking session completed $e");
    }
  }

  markLevelompleted(payload) async {
    try {
      var response =
          await apiProvider.postSecure(markLevelompletedEndpoint, payload);
      log("Api response level mark $response");
    } catch (e) {
      log("Error marking level completed $e");
    }
  }

  markCourseompleted(payload) async {
    try {
      var response =
          await apiProvider.postSecure(markCourseCompletedEndpoint, payload);
      log("Api response course mark $response");
    } catch (e) {
      log("Error marking course completed $e");
    }
  }
}
