// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/courses/view/course_details/course_details.dart';
import 'package:e_learn/pages/payment/controller/payment_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PaymentPage extends StatelessWidget {
  final String productId;
  final String name;
  final String description;
  final String imageUrl;
  final String price;

  PaymentPage(
      {super.key,
      required this.productId,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.price});

  final RxString _selectedValue = 'paypal'.obs;
  PaymentController paymentController = Get.put(PaymentController());
  CoursesController coursesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: FloatingActionButton.extended(
          onPressed: () async {
            var payload = {
              "product_id": productId,
              "price": price,
              "payment_method": _selectedValue.value
            };
            var response = await paymentController.makeProductPurchase(payload);

            if (response) {
              paymentSuccessDialog(context);
            } else {
              paymentFailedDialog(context);
            }
          },
          label: Obx(
            () {
              return paymentController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Enroll Course - ₹$price',
                      style: headingFontStyle.copyWith(
                          fontSize: 18, color: Colors.white),
                    );
            },
          ),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Image.asset('assets/icons/back_arrow_ic.png'),
                    color: Colors.white,
                  ),
                  Text(
                    'Payment',
                    style: headingFontStyle.copyWith(fontSize: 21),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              productCard(),
              const SizedBox(height: 20),
              Text(
                'Select the Payment Methods you Want to Use',
                style: descriptionFontStyle,
              ),
              const SizedBox(height: 20),
              paymentModes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.10),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    maxLines: 2,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    name,
                    style: headingFontStyle.copyWith(
                      color: fontTitleColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 200,
                  child: AutoSizeText(
                    maxLines: 3,
                    minFontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    description,
                    style: headingFontStyle.copyWith(fontSize: 14),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget paymentModes() {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Obx(() {
              return Row(
                children: [
                  Radio<String>(
                    value: 'paypal',
                    groupValue: _selectedValue.value,
                    onChanged: (String? value) {
                      _selectedValue.value = value!;
                    },
                  ),
                  Text('Paypal')
                ],
              );
            })),
        const SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Obx(
              () {
                return Row(
                  children: [
                    Radio<String>(
                      value: 'upi',
                      groupValue: _selectedValue.value,
                      onChanged: (String? value) {
                        _selectedValue.value = value!;
                      },
                    ),
                    Text('UPI')
                  ],
                );
              },
            )),
        const SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Obx(
              () {
                return Row(
                  children: [
                    Radio<String>(
                      value: 'card',
                      groupValue: _selectedValue.value,
                      onChanged: (String? value) {
                        _selectedValue.value = value!;
                      },
                    ),
                    Text('Card')
                  ],
                );
              },
            )),
        const SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Obx(
              () {
                return Row(
                  children: [
                    Radio<String>(
                      value: 'netBanking',
                      groupValue: _selectedValue.value,
                      onChanged: (String? value) {
                        _selectedValue.value = value!;
                      },
                    ),
                    Text('Net Banking')
                  ],
                );
              },
            )),
      ],
    );
  }

  void paymentSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 20),
                Image.asset('assets/images/message/sucess_img.png'),
                const SizedBox(height: 10),
                Text('Congratulations', style: headingFontStyle),
                const SizedBox(height: 10),
                Text(
                  'Your Payment is Successfully. Purchase a New Course',
                  style: descriptionFontStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'E - Receipt',
                  style: headingFontStyle.copyWith(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: componentsColor),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      coursesController.getCourseDetails(productId);
                      coursesController.getProductReview(productId);
                      Get.to(CourseDetails(
                        isPurchased: true,
                      ));
                    },
                    child: Center(
                      child: Text(
                        'Explore Course',
                        style: headingFontStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void paymentFailedDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/message/failed_img.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 10),
                Text('Purchase Failed', style: headingFontStyle),
                const SizedBox(height: 10),
                Text(
                  'Your purchase failed due to some issues',
                  style: descriptionFontStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'E - Receipt',
                  style: headingFontStyle.copyWith(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: componentsColor),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Explore Course',
                        style: headingFontStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
