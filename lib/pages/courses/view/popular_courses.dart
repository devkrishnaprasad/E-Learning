import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:e_learn/utils/widgets/courses_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularCourses extends StatelessWidget {
  const PopularCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    'Popular Courses',
                    style: headingFontStyle.copyWith(fontSize: 21),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              filterCards(context),
              const SizedBox(height: 20),
              courseCards(context),
            ],
          ),
        ),
      )),
    );
  }
}

Widget filterCards(context) {
  RxInt selectedIndex = 0.obs;
  return SizedBox(
    height: 30,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(onTap: () {
          selectedIndex.value = index;
        }, child: Obx(() {
          return Container(
            height: 30,
            decoration: BoxDecoration(
              color: selectedIndex.value == index
                  ? componentsColor
                  : cardBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Item $index',
                style: TextStyle(
                  fontSize: 13,
                  color: selectedIndex.value == index
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        }));
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 5);
      },
      itemCount: 10, // Update this to the actual number of items
    ),
  );
}

Widget courseCards(context) {
  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const CoursesCard();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
      itemCount: 10);
}
