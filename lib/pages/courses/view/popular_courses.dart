import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:e_learn/utils/widgets/courses_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopularCourses extends StatelessWidget {
  PopularCourses({super.key});
  HelperController helperController = Get.find();
  RxString categoryId = ''.obs;
  RxList courseList = [].obs;

  @override
  Widget build(BuildContext context) {
    courseList.value = helperController.allPopularCoursesList;
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

  Widget filterCards(context) {
    RxInt selectedIndex = 0.obs;

    return SizedBox(
      height: 30,
      child: Obx(() {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  // If "All" is selected, show all courses
                  courseList.value = helperController.allPopularCoursesList;
                } else {
                  // Otherwise, filter by the selected category
                  courseList.value = helperController.allPopularCoursesList
                      .where((course) =>
                          course.productCategory ==
                          helperController
                              .allCourseCategooryList[index - 1].categoryId)
                      .toList();
                }
                selectedIndex.value = index;

                print("The Selected imdex is ${selectedIndex.value}  $index");
              },
              child: Obx(
                () {
                  return Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: selectedIndex.value == index
                          ? componentsColor
                          : cardBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        index == 0
                            ? 'All'
                            : helperController
                                .allCourseCategooryList[index - 1].categoryName,
                        style: TextStyle(
                          fontSize: 13,
                          color: selectedIndex.value == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 5);
          },
          itemCount: helperController.allCourseCategooryList.length +
              1, // +1 for the "All" category
        );
      }),
    );
  }

  Widget courseCards(context) {
    return Obx(() {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var data = courseList[index];
            return CoursesCard(
              imageUrl: data.productImage,
              title: data.productName,
              description: data.about,
              price: data.price,
              offerPrice: data.offerPrice,
              rating: data.rating,
              studentsCount: data.sessionCount,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          itemCount: courseList.length);
    });
  }
}
