import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({super.key});
  RxInt currentIndicationCount = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Skip",
                    style: descriptionFontStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Obx(
                    () {
                      return Column(
                        children: [
                          currentIndicationCount.value == 0
                              ? Text(
                                  'Online Learning',
                                  style: headingFontStyle,
                                )
                              : currentIndicationCount.value == 1
                                  ? Text(
                                      'Learn from Anytime',
                                      style: headingFontStyle,
                                    )
                                  : Text(
                                      'Get Online Certificate',
                                      style: headingFontStyle,
                                    ),
                          const SizedBox(height: 5),
                          currentIndicationCount.value == 0
                              ? Text(
                                  'We Provide Classes Online Classes and Pre Recorded Leactures.!',
                                  textAlign: TextAlign.center,
                                  style: descriptionFontStyle,
                                )
                              : currentIndicationCount.value == 1
                                  ? Text(
                                      'Booked or Same the Lectures for Future',
                                      textAlign: TextAlign.center,
                                      style: descriptionFontStyle,
                                    )
                                  : Text(
                                      'Analyse your scores and Track your results',
                                      textAlign: TextAlign.center,
                                      style: descriptionFontStyle,
                                    )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 190),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return DotsIndicator(
                            dotsCount: 3,
                            position: currentIndicationCount.value,
                            decorator: DotsDecorator(
                              activeColor: primaryColor,
                              color: secondaryColor,
                              size: const Size.square(9.0),
                              activeSize: const Size(20.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        },
                      ),
                      Obx(() {
                        return currentIndicationCount.value == 2
                            ? Container(
                                width: 180,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        'Get Started',
                                        style: headingFontStyle.copyWith(
                                          fontSize: 16,
                                          color: overlayColor,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: overlayColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/icons/right_arrow_ic.png',
                                            color: primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(15),
                                ),
                                onPressed: () {
                                  if (currentIndicationCount.value != 2) {
                                    currentIndicationCount.value += 1;
                                  }
                                },
                                child: Image.asset(
                                    'assets/icons/right_arrow_ic.png'),
                              );
                      })
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
