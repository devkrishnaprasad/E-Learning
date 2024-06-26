import 'package:e_learn/pages/components/cards/session_cards.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:e_learn/utils/warppers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class CourseDetails extends StatelessWidget {
  CourseDetails({super.key});
  CoursesController coursesController = Get.find();
  HelperController helperController = Get.find();
  Warppers warppers = Warppers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (coursesController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            helperController.videoPlayer(
                coursesController.courseDetails[0].productDetails.videoUrl);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      videoPlayer(context),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Image.asset('assets/icons/back_arrow_ic.png'),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        courseDetails(context),
                        const SizedBox(height: 10),
                        instructorWidget(),
                        const SizedBox(height: 20),
                        courseBenifitsWidget(),
                        const SizedBox(height: 40),
                        userRevieew(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ),
      floatingActionButton: Obx(() {
        return coursesController.isLoading.value
            ? const SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text(
                    'Enroll Course - ₹${coursesController.courseDetails[0].productDetails.price}',
                    style: headingFontStyle.copyWith(
                        fontSize: 18, color: Colors.white),
                  ),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget videoPlayer(context) {
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

  Widget courseDetails(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      coursesController
                          .courseDetails[0].productDetails.productName,
                      style: headingFontStyle.copyWith(
                        color: fontTitleColor,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Text(
                          coursesController
                              .courseDetails[0].productDetails.rating,
                          style: headingFontStyle.copyWith(fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(coursesController.courseDetails[0].productDetails.about,
                    style: headingFontStyle.copyWith(fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Iconsax.video_play),
                        const SizedBox(width: 10),
                        Text(
                          "${coursesController.courseDetails[0].productDetails.sessionCount} class",
                          style: headingFontStyle.copyWith(fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 2,
                          height: 20,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Iconsax.clock),
                        const SizedBox(width: 10),
                        Text(
                          warppers.convertMinutesToHours(coursesController
                              .courseDetails[0].productDetails.totalDuration),
                          style: headingFontStyle.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "₹${coursesController.courseDetails[0].productDetails.price}",
                      style: headingTagFontStyle.copyWith(
                          fontSize: 17, color: primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          toggleButton(context),
        ],
      ),
    );
  }

  Widget toggleButton(context) {
    RxBool isAbout = true.obs;
    return Obx(() {
      return Column(
        children: [
          Container(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 185,
                      height: 50,
                      child: Obx(() {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAbout.value
                                ? backgroundColor
                                : secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: () {
                            isAbout.value = true;
                          },
                          child: Center(
                            child: Text(
                              'About',
                              style: headingFontStyle.copyWith(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                        );
                      })),
                  SizedBox(
                    width: 185,
                    height: 50,
                    child: Obx(
                      () {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAbout.value
                                ? secondaryColor
                                : backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          onPressed: () {
                            isAbout.value = false;
                          },
                          child: Center(
                            child: Text(
                              'Curriculcum',
                              style: headingFontStyle.copyWith(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
            child: isAbout.value
                ? aboutDetailsWidget()
                : curriculumDetailsWidget(),
          )
        ],
      );
    });
  }

  Widget aboutDetailsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          coursesController.courseDetails[0].productDetails.about,
          style: headingTagFontStyle.copyWith(
              color: fontSecondaryColor, fontSize: 13),
        )
      ],
    );
  }

  Widget curriculumDetailsWidget() {
    return Column(
      children: [
        SessionCards(
          indexCount: coursesController.courseDetails[0].sessions.length,
          listData: coursesController.courseDetails[0].sessions,
        )
      ],
    );
  }

  Widget instructorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructor',
          style: headingFontStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/mentor_img.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      'Krishnaprasad',
                      style: headingFontStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'App Developer',
                      style: headingFontStyle.copyWith(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/message_ic.png'))
          ],
        ),
        const SizedBox(height: 20),
        const Divider(thickness: 0.2),
      ],
    );
  }

  Widget courseBenifitsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What You’ll Get',
          style: headingFontStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Image.asset('assets/icons/course_icons/class_ic.png'),
            const SizedBox(width: 10),
            Text(
              '25 Lessons',
              style: headingTagFontStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Image.asset('assets/icons/course_icons/mobile_ic.png'),
            const SizedBox(width: 10),
            Text(
              'Access Mobile, Desktop & TV',
              style: headingTagFontStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Image.asset('assets/icons/course_icons/level_ic.png'),
            const SizedBox(width: 10),
            Text(
              'Beginner Level',
              style: headingTagFontStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Image.asset('assets/icons/course_icons/access_ic.png'),
            const SizedBox(width: 10),
            Text(
              'Lifetime Access',
              style: headingTagFontStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Image.asset('assets/icons/course_icons/class_ic.png'),
            const SizedBox(width: 10),
            Text(
              'Certificate of Completion',
              style: headingTagFontStyle.copyWith(fontSize: 14),
            )
          ],
        )
      ],
    );
  }

  Widget userRevieew() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: headingFontStyle.copyWith(fontSize: 18),
            ),
            Row(
              children: [
                Text(
                  "SEE ALL",
                  style: headingTagFontStyle.copyWith(color: primaryColor),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: primaryColor,
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/mentor_img.png'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coursesController
                                  .productReviewDetails[index].username,
                              style: headingFontStyle.copyWith(fontSize: 17),
                            ),
                            SizedBox(
                              width: 245,
                              child: Text(
                                coursesController.productReviewDetails[index]
                                    .reviewDescription,
                                style: headingTagFontStyle.copyWith(
                                    fontSize: 13, color: fontSecondaryColor),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      coursesController
                                                  .productReviewDetails[index]
                                                  .noOfLikes ==
                                              "NA"
                                          ? '10'
                                          : coursesController
                                              .productReviewDetails[index]
                                              .noOfLikes,
                                      style: headingTagFontStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  warppers.timeAgo(coursesController
                                      .productReviewDetails[index]
                                      .lastModified),
                                  style: headingTagFontStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: primaryColor,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.star,
                              color: yellowColor,
                            ),
                            Text(
                              coursesController
                                  .productReviewDetails[index].rating,
                              style: headingFontStyle.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Column(
              children: [
                SizedBox(height: 10),
                Divider(
                  thickness: 0.2,
                ),
                SizedBox(height: 10),
              ],
            );
          },
          itemCount: coursesController.productReviewDetails.length,
        )
      ],
    );
  }
}
