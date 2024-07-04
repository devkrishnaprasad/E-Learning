import 'dart:developer';
import 'package:e_learn/pages/payment/controller/api/payment_api.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  PaymentApiService paymentApiService = PaymentApiService();
  RxBool isLoading = false.obs;
  HelperController helperController = Get.find();

  makeProductPurchase(payload) async {
    try {
      isLoading.value = true;
      var response = await paymentApiService.purchaseProduct(payload);
      if (response == true) {
        await helperController.getPurchaseDetails();
      }
      return true;
    } catch (e) {
      log('Product Purchase failed : $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
