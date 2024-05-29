import 'dart:developer';

import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categorys extends StatelessWidget {
  const Categorys({super.key});

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
}

Widget categoryGridWidget(BuildContext context) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: 10,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          log('Selected Item index is $index');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/category_ic.png'),
            const SizedBox(height: 5),
            Text(
              '3D Design',
              style: headingTagFontStyle.copyWith(
                  fontSize: 14, color: fontSecondaryColor),
            ),
          ],
        ),
      );
    },
  );
}
