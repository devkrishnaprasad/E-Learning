import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class OffersCards extends StatelessWidget {
  final String discount;
  final String title;
  final String description;
  final String imagePath;

  const OffersCards({
    super.key,
    required this.discount,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discount,
                  style: headingTagFontStyle.copyWith(color: overlayColor),
                ),
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: AutoSizeText(
                          maxLines: 1,
                          minFontSize: 22,
                          title,
                          style: headingTagFontStyle.copyWith(
                              color: overlayColor, fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 220,
                        child: AutoSizeText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 13,
                          description,
                          style: headingTagFontStyle.copyWith(
                              color: overlayColor, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: 120,
              height: 120,
              child: Image.network(imagePath),
            )
          ],
        ),
      ),
    );
  }
}
