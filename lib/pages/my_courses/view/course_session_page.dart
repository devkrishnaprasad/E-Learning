import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/pages/components/cards/session_cards.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/my_courses/controller/my_course_controller.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CourseSessionPage extends StatelessWidget {
  final String courseName;
  final bool isComplected; // Add a member variable to store the parameter

  CourseSessionPage(
      {super.key, required this.courseName, required this.isComplected});

  CoursesController coursesController = Get.find();
  MyCourseController myCourseController = Get.find();
  HelperController helperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: !isComplected
          ? Container(
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 55,
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(secondaryColor),
                      ),
                      onPressed: () {},
                      child: Center(
                        child: Image.asset(
                            'assets/icons/course_icons/certificate_ic.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Start Course Again',
                        style: headingFontStyle.copyWith(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            )
          : const SizedBox(),
      body: SafeArea(
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
                SizedBox(
                  width: 350,
                  child: AutoSizeText(
                    maxLines: 1,
                    minFontSize: 21,
                    overflow: TextOverflow.ellipsis,
                    courseName,
                    style: headingFontStyle.copyWith(fontSize: 21),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (coursesController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      videoPlayer(context),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: sessionWidget(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget videoPlayer(context) {
    helperController.videoPlayer(
        helperController.currentSessionVideoUrl.value, false);
    return Obx(
      () {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.black,
          child: Center(
            child: helperController.isVideoLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : helperController.playerWidget.value,
          ),
        );
      },
    );
  }

  Widget sessionWidget() {
    return Column(
      children: [
        SessionCards(
          isPurchased: true,
          indexCount: coursesController.courseDetails[0].sessions.length,
          listData: coursesController.courseDetails[0].sessions,
        )
      ],
    );
  }
}
