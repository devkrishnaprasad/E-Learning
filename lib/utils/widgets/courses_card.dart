import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: overlayColor,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: 130,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/course_img.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          cardDetailsWidget()
        ],
      ),
    );
  }
}

Widget cardDetailsWidget() {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Graphic Design',
              style: headingFontStyle.copyWith(
                  color: fontTitleColor, fontSize: 12),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/save_ic.png'),
            )
          ],
        ),
        Text(
          'Graphic Design Advanced',
          style: headingFontStyle.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹28',
              style: headingTagFontStyle.copyWith(
                  fontSize: 17, color: primaryColor),
            ),
            const SizedBox(width: 5),
            Text(
              '₹61',
              style: headingFontStyle.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13,
                  color: fontSecondaryColor),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow, size: 20),
            const SizedBox(width: 5),
            Text(
              '3.9',
              style: headingFontStyle.copyWith(fontSize: 13),
            ),
            const SizedBox(width: 20),
            Container(
              height: 15,
              width: 2,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Text(
              '12680 Std',
              style: headingFontStyle.copyWith(fontSize: 13),
            ),
          ],
        )
      ],
    ),
  );
}
