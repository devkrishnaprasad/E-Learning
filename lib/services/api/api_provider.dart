import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learn/services/api/constants.dart';
import 'package:e_learn/services/helper/local_storage/local_storage.dart';

class ApiProvider {
  var dio = Dio();
  LocalStorage localStorage = LocalStorage();
  getRequest(apiUrl) async {
    log("The Api Url : $BASEURL/$apiUrl");
    var response = await dio.request(
      '$BASEURL/$apiUrl',
      options: Options(
        method: 'GET',
      ),
    );
    if (response.statusCode == 200) {
      return response.data;
    } else {
      log(response.statusMessage.toString());
    }
  }

  postRequest(apiUrl, payload) async {
    log("The Api Url : $BASEURL/$apiUrl");
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();
    var response = await dio.request(
      '$BASEURL/$apiUrl',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: payload,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      log(response.statusMessage.toString());
    }
  }

  getSecure(apiUrl) async {
    var token = await localStorage.readUserToken();
    log("The Api Url : $BASEURL/$apiUrl");

    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    var response = await dio.request(
      '$BASEURL/$apiUrl',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      log(response.statusMessage.toString());
    }
  }

  postSecure(apiUrl, payload) async {
    var token = await localStorage.readUserToken();
    log("The Api Url : $BASEURL/$apiUrl");

    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    var response = await dio.request(
      '$BASEURL/$apiUrl',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: payload,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      log(response.statusMessage.toString());
    }
  }
}
