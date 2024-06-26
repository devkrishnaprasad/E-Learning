import 'package:e_learn/pages/components/cards/session_cards.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CourseSessionPage extends StatelessWidget {
  final bool isComplected; // Add a member variable to store the parameter

  CourseSessionPage({super.key, required this.isComplected});

  CoursesController coursesController = Get.find();
  HelperController helperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
      ),
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
                Text(
                  'My Courses',
                  style: headingFontStyle.copyWith(fontSize: 21),
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
                          child: sessionWidget(),
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
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
    return Obx(
      () {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.black,
          child: Center(
            child: helperController.playerWidget.value,
          ),
        );
      },
    );
  }

  Widget sessionWidget() {
    return Column(
      children: [
        SessionCards(
          indexCount: coursesController.courseDetails[0].sessions.length,
          listData: coursesController.courseDetails[0].sessions,
        )
      ],
    );
  }
}
