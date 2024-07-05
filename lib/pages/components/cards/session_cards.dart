import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/main.dart';
import 'package:e_learn/pages/my_courses/controller/my_course_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:e_learn/utils/warppers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SessionCards extends StatelessWidget {
  final int indexCount;
  final dynamic listData;
  bool isPurchased;

  SessionCards({
    super.key,
    required this.indexCount,
    required this.listData,
    required this.isPurchased,
  });
  Warppers warppers = Warppers();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Session ${index + 1} - ",
                      style: headingFontStyle.copyWith(fontSize: 15),
                    ),
                    SizedBox(
                      width: 200,
                      child: AutoSizeText(
                        minFontSize: 15,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        listData[index].sessionTitle,
                        style: headingFontStyle.copyWith(
                            fontSize: 15, color: primaryColor),
                      ),
                    )
                  ],
                ),
                Text(
                  warppers
                      .convertMinutesToHours(listData[index].sessionDuration),
                  style: headingTagFontStyle.copyWith(
                      fontSize: 12, color: primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, levelIndex) {
                return levelWidget(levelIndex, listData[index].levels, index,
                    listData[index].sessionId);
              },
              separatorBuilder: (context, levelIndex) {
                return const Column(
                  children: [
                    SizedBox(height: 10),
                    Divider(thickness: 0.2),
                    SizedBox(height: 10),
                  ],
                );
              },
              itemCount: listData[index].levels.length,
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Column(
          children: [
            SizedBox(height: 10),
            Divider(thickness: 0.2),
            SizedBox(height: 10)
          ],
        );
      },
      itemCount: indexCount,
    );
  }

  Widget levelWidget(levelIndex, listData, index, sessionId) {
    RxBool isComplected = false.obs;

    RxBool isPurchasedCourse = false.obs;
    isPurchasedCourse.value = isPurchased;
    if (isPurchased) {
      MyCourseController myCourseController = Get.find();
      isComplected.value = myCourseController.levelRecord
          .any((record) => record.levelId == listData[levelIndex].levelId);
    }
    return GestureDetector(
      onTap: () {
        if (isPurchased) {
          MyCourseController myCourseController = Get.find();
          log('Current level id : ${myCourseController.currentLevelId.value}');
          log("The level id ${listData[levelIndex].levelId}");
          log("The session id $sessionId");
          log("Current session id ${myCourseController.currentSessionId.value}");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(
                () {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isPurchasedCourse.value
                          ? isComplected.value
                              ? Colors.green
                              : secondaryColor
                          : secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "${levelIndex + 1}",
                        style: headingFontStyle.copyWith(
                          fontSize: 14,
                          color: isPurchasedCourse.value
                              ? isComplected.value
                                  ? Colors.white
                                  : Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: AutoSizeText(
                      minFontSize: 15,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      listData[levelIndex].levelTitle,
                      style: headingFontStyle.copyWith(fontSize: 15),
                    ),
                  ),
                  Text(
                    warppers
                        .convertMinutesToHours(listData[levelIndex].duration),
                    style: headingTagFontStyle.copyWith(
                        fontSize: 13, color: fontSecondaryColor),
                  )
                ],
              )
            ],
          ),
          IconButton(
            onPressed: () {
              if (isPurchased) {
                MyCourseController myCourseController = Get.find();
                myCourseController.currentLevelId.value =
                    listData[levelIndex].levelId;
                myCourseController.currentSessionId.value = sessionId;
                helperController.currentSessionVideoUrl.value =
                    listData[levelIndex].videoPath;
              }
            },
            icon: isPurchased
                ? Image.asset('assets/icons/play_ic.png')
                : index == 0
                    ? Image.asset('assets/icons/play_ic.png')
                    : Image.asset('assets/icons/lock_ic.png'),
          )
        ],
      ),
    );
  }
}
