import 'dart:developer';

import 'package:e_learn/pages/my_courses/model/purchase_model.dart';
import 'package:e_learn/services/api/api_provider.dart';
import 'package:e_learn/services/api/constants.dart';

class MyCourseApi {
  ApiProvider apiProvider = ApiProvider();

  Future<List<PurchaseRecord>> getPurchaseDetails() async {
    List<PurchaseRecord> purchaseList = [];
    try {
      var response = await apiProvider.getSecure(getPurchaseDetailsEndpoint);
      purchaseList = response
          .map<PurchaseRecord>((p) => PurchaseRecord.fromJson(p))
          .toList();

      if (response.isNotEmpty) {
        return purchaseList;
      }
    } catch (e) {
      log("Error while getPurchaseDetails : $e");
      return [];
    }
    return [];
  }
}
