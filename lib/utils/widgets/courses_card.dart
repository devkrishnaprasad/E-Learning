import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class CoursesCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String offerPrice;
  final String rating;
  final String studentsCount;

  const CoursesCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.offerPrice,
    required this.rating,
    required this.studentsCount,
  });

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
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
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

  Widget cardDetailsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: AutoSizeText(
                  minFontSize: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: headingFontStyle.copyWith(
                      color: fontTitleColor, fontSize: 12),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/save_ic.png'),
              )
            ],
          ),
          SizedBox(
            width: 210,
            child: AutoSizeText(
              minFontSize: 14,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              description,
              style: headingFontStyle.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹$price',
                style: headingTagFontStyle.copyWith(
                    fontSize: 17, color: primaryColor),
              ),
              const SizedBox(width: 5),
              Text(
                '₹$offerPrice',
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
              const Icon(Icons.star, color: yellowColor, size: 20),
              const SizedBox(width: 5),
              Text(
                rating,
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
                '$studentsCount Std',
                style: headingFontStyle.copyWith(fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}
