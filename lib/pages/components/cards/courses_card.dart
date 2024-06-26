import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/pages/certificate/certificate.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCoursesCard extends StatelessWidget {
  final bool isCompleted;
  final String imageUrl;
  final String courseTitle;
  final String courseDescription;
  final String rating;
  final String duration;
  final String sessionCount;
  const MyCoursesCard(
      {super.key,
      required this.isCompleted,
      required this.imageUrl,
      required this.courseTitle,
      required this.courseDescription,
      required this.rating,
      required this.duration,
      required this.sessionCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: overlayColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: boxShadowColor,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          courseTitle,
                          style: headingFontStyle.copyWith(
                              fontSize: 12, color: fontTitleColor),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 230,
                        child: AutoSizeText(
                            maxLines: 1,
                            minFontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            courseDescription,
                            style: headingFontStyle.copyWith(fontSize: 16)),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: yellowColor,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rating,
                            style: headingFontStyle.copyWith(fontSize: 11),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 15,
                            width: 2,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            duration,
                            style: headingFontStyle.copyWith(fontSize: 11),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (!isCompleted)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 160,
                              child: LinearProgressIndicator(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                value: 0.5,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    componentsColor),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '93/$sessionCount',
                              style: headingTagFontStyle.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      if (isCompleted)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(CertificatePage());
                              },
                              child: Text(
                                'VIEW CERTIFICATE',
                                style: headingTagFontStyle.copyWith(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  color: componentsColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isCompleted)
          Positioned(
            top: -5,
            right: 5,
            child: Image.asset(
              'assets/icons/course_icons/completed_ic.png',
              width: 50,
              height: 50,
            ),
          ),
      ],
    );
  }
}
