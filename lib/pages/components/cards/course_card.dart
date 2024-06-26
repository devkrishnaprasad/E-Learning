import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final String studentCount;

  const CourseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.studentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: overlayColor,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 240,
                      child: AutoSizeText(
                        minFontSize: 12,
                        maxLines: 1,
                        title,
                        style: descriptionFontStyle.copyWith(
                            color: fontTitleColor),
                      ),
                    ),
                    Image.asset('assets/icons/save_ic.png')
                  ],
                ),
                SizedBox(
                  width: 240,
                  child: AutoSizeText(
                    maxLines: 2,
                    minFontSize: 12,
                    subtitle,
                    style: headingFontStyle.copyWith(fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: headingTagFontStyle.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 15,
                      width: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: yellowColor,
                        ),
                        Text(
                          rating,
                          style: headingTagFontStyle.copyWith(
                              fontSize: 11, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Container(
                      height: 15,
                      width: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      studentCount,
                      style: headingTagFontStyle.copyWith(
                          fontSize: 11, fontWeight: FontWeight.w900),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
