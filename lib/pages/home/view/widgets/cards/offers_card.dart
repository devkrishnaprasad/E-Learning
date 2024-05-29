import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';

class OffersCards extends StatelessWidget {
  const OffersCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
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
                  '25% Off*',
                  style: headingTagFontStyle.copyWith(color: overlayColor),
                ),
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today’s Special',
                        style: headingTagFontStyle.copyWith(
                            color: overlayColor, fontSize: 22),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Get a Discount for Every Course Order only Valid for Today.!',
                        style: headingTagFontStyle.copyWith(
                            color: overlayColor, fontSize: 13),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: 120,
              height: 120,
              child: Image.asset('assets/icons/offer_ic.png'),
            )
          ],
        ),
      ),
    );
  }
}
