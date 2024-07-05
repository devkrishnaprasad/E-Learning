import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/courses/view/popular_courses.dart';
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
  HelperController helperController = Get.find();
  CoursesController coursesController = Get.find();
  MyCourseController myCourseController = Get.put(MyCourseController());
  RxBool isOnGoing = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () {
              if (helperController.isLoading.value) {
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
                            'My Courses',
                            style: headingFontStyle.copyWith(fontSize: 21),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      searchField(),
                      const SizedBox(height: 20),
                      toggleButton(context),
                      const SizedBox(height: 20),
                      helperController.purchaseDetails.isEmpty
                          ? Column(
                              children: [
                                const SizedBox(height: 40),
                                Image.asset(
                                  'assets/images/message/empty_list.png',
                                  width: 250,
                                  height: 250,
                                ),
                                Text(
                                  'You have not purchased any course.',
                                  style:
                                      headingFontStyle.copyWith(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  height: 60,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(PopularCourses());
                                    },
                                    child: Text(
                                      'Explor Course',
                                      style: headingFontStyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Obx(
                              () {
                                return isOnGoing.value
                                    ? onGoingCoursesWidget(context)
                                    : completedCoursesWidget(context);
                              },
                            )
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
            var data = helperController.purchaseDetails[index];

            return GestureDetector(
              onTap: () async {
                await coursesController.getCourseDetails(data.productId);
                await myCourseController.getLevelRecord(data.productId);
                await myCourseController.getSessionRecord(data.productId);
                Get.to(CourseSessionPage(
                  courseName: data.productName,
                  isComplected: true,
                ));
              },
              child: MyCoursesCard(
                sessionCount: data.sessionCount,
                imageUrl: data.productImage,
                courseTitle: data.productName,
                courseDescription: data.about,
                rating: data.rating,
                duration: data.totalDuration,
                isCompleted: helperController.completedCourseDetails
                    .any((element) => element.productId == data.productId),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: helperController.purchaseDetails.length,
        ),
      ],
    );
  }

  Widget completedCoursesWidget(context) {
    final completedProductIds = helperController.completedCourseDetails
        .map((course) => course.productId)
        .toSet();

    final completedPurchaseDetails = helperController.purchaseDetails
        .where((purchase) => completedProductIds.contains(purchase.productId))
        .toList();

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = completedPurchaseDetails[index];
            return GestureDetector(
              onTap: () async {
                await coursesController.getCourseDetails(data.productId);
                await myCourseController.getLevelRecord(data.productId);
                myCourseController.getSessionRecord(data.productId);
                Get.to(CourseSessionPage(
                  courseName: data.productName,
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
          itemCount: completedPurchaseDetails.length,
        )
      ],
    );
  }
}
