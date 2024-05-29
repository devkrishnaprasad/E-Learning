import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:e_learn/utils/widgets/courses_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCourses extends StatelessWidget {
  const AllCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              topBarWidget(),
              const SizedBox(height: 20),
              midlayerWidget(),
              const SizedBox(height: 20),
              courseCards(context),
            ],
          ),
        ),
      )),
    );
  }
}

Widget topBarWidget() {
  return Column(
    children: [
      Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset('assets/icons/back_arrow_ic.png'),
          ),
          Text(
            'Online Courses',
            style: headingFontStyle.copyWith(fontSize: 21),
          ),
        ],
      ),
      const SizedBox(height: 20),
      TextFormField(
        onTap: () {},
        decoration: InputDecoration(
          hintText: 'Search for..',
          suffixIcon: Image.asset('assets/icons/filter_ic.png'),
        ),
      )
    ],
  );
}

Widget midlayerWidget() {
  RxBool isCourses = true.obs;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 175,
            child: Obx(
              () {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          isCourses.value ? componentsColor : cardBackground)),
                  onPressed: () {
                    isCourses.value = true;
                  },
                  child: Text('Courses',
                      style: headingFontStyle.copyWith(
                          fontSize: 15,
                          color:
                              isCourses.value ? Colors.white : Colors.black)),
                );
              },
            ),
          ),
          SizedBox(
            height: 50,
            width: 175,
            child: Obx(
              () {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          isCourses.value ? cardBackground : componentsColor)),
                  onPressed: () {
                    isCourses.value = false;
                  },
                  child: Text('Mentors',
                      style: headingFontStyle.copyWith(
                          fontSize: 15,
                          color:
                              isCourses.value ? Colors.black : Colors.white)),
                );
              },
            ),
          )
        ],
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Results for ',
                style: headingFontStyle.copyWith(fontSize: 15),
              ),
              Text(
                '"Graphic Design"',
                style: headingFontStyle.copyWith(
                    fontSize: 15, color: primaryColor),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '2480 FOUND',
                style: headingFontStyle.copyWith(
                    color: primaryColor, fontSize: 12),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: primaryColor,
              )
            ],
          )
        ],
      )
    ],
  );
}

Widget courseCards(context) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return const CoursesCard();
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 10);
    },
    itemCount: 10,
  );
}
