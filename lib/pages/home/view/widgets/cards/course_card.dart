import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

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
              child: Image.asset(
                'assets/images/course_img.jpeg',
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
                    Text(
                      'Graphic Design',
                      style:
                          descriptionFontStyle.copyWith(color: fontTitleColor),
                    ),
                    Image.asset('assets/icons/save_ic.png')
                  ],
                ),
                Text(
                  'Graphic Design Advanced',
                  style: headingFontStyle.copyWith(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      '₹28',
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
                          color: Colors.yellow,
                        ),
                        Text(
                          '4.2',
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
                      '7830 Std',
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
