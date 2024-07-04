import 'dart:developer';

import 'package:e_learn/services/api/api_provider.dart';
import 'package:e_learn/services/api/constants.dart';

class PaymentApiService {
  ApiProvider apiProvider = ApiProvider();
  purchaseProduct(payload) async {
    try {
      var response =
          await apiProvider.postSecure(purchaseProductEndpoint, payload);
      return response[0]['status'];
    } catch (e) {
      log('Purchase error : $e');
    }
  }
}
