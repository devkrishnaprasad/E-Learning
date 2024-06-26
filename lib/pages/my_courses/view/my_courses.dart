import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/filter/filters.dart';
import 'package:e_learn/pages/my_courses/controller/my_course_controller.dart';
import 'package:e_learn/pages/my_courses/view/course_session_page.dart';
import 'package:e_learn/pages/components/cards/courses_card.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyCourses extends StatelessWidget {
  MyCourses({super.key});
  MyCourseController myCourseController = Get.put(MyCourseController());
  HelperController helperController = Get.find();
  CoursesController coursesController = Get.find();
  RxBool isOnGoing = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () {
              if (myCourseController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Popular Courses',
                            style: headingFontStyle.copyWith(fontSize: 21),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      searchField(),
                      const SizedBox(height: 20),
                      toggleButton(context),
                      const SizedBox(height: 20),
                      Obx(() {
                        return isOnGoing.value
                            ? onGoingCoursesWidget(context)
                            : completedCoursesWidget(context);
                      })
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget searchField() {
    return TextFormField(
      onTap: () {},
      decoration: InputDecoration(
        hintText: 'Search for..',
        suffixIcon: IconButton(
            onPressed: () {
              helperController.getAllCoursesList();
              Get.to(const Fillters());
            },
            icon: Image.asset('assets/icons/search_box_ic.png')),
      ),
    );
  }

  Widget toggleButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            isOnGoing.value = true;
          },
          child: Obx(
            () {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                    color: isOnGoing.value ? componentsColor : secondaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Ongoing',
                    style: headingTagFontStyle.copyWith(
                        color: isOnGoing.value ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            isOnGoing.value = false;
          },
          child: Obx(
            () {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                    color: isOnGoing.value ? secondaryColor : componentsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Completed',
                    style: headingTagFontStyle.copyWith(
                        color: !isOnGoing.value ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget onGoingCoursesWidget(context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = myCourseController.purchaseDetails[index];
            return GestureDetector(
              onTap: () {
                coursesController.getCourseDetails(data.productId);
                Get.to(CourseSessionPage(
                  isComplected: false,
                ));
              },
              child: MyCoursesCard(
                sessionCount: data.sessionCount,
                imageUrl: data.productImage,
                courseTitle: data.productName,
                courseDescription: data.about,
                rating: data.rating,
                duration: data.totalDuration,
                isCompleted: false,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: myCourseController.purchaseDetails.length,
        )
      ],
    );
  }

  Widget completedCoursesWidget(context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = myCourseController.purchaseDetails[index];
            return GestureDetector(
              onTap: () {
                coursesController.getCourseDetails(data.productId);
                Get.to(CourseSessionPage(
                  isComplected: true,
                ));
              },
              child: MyCoursesCard(
                imageUrl: data.productImage,
                courseTitle: data.productName,
                courseDescription: data.about,
                rating: data.rating,
                duration: data.totalDuration,
                sessionCount: data.sessionCount,
                isCompleted: true,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: myCourseController.purchaseDetails.length,
        )
      ],
    );
  }
}
