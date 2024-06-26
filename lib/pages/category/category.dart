import 'dart:developer';

import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Categorys extends StatelessWidget {
  Categorys({super.key});
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Image.asset('assets/icons/back_arrow_ic.png'),
                  ),
                  Text(
                    'All Category',
                    style: headingFontStyle.copyWith(fontSize: 21),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Search for..',
                    suffixIcon: Image.asset('assets/icons/search_box_ic.png')),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: categoryGridWidget(context),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget categoryGridWidget(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: helperController.allCourseCategooryList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            log('Selected Item index ID ${helperController.allCourseCategooryList[index].categoryId}');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  helperController.allCourseCategooryList[index].categoryImage),
              const SizedBox(height: 5),
              Text(
                helperController.allCourseCategooryList[index].categoryName,
                style: headingTagFontStyle.copyWith(
                    fontSize: 14, color: fontSecondaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
