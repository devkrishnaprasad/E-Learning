import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Fillters extends StatelessWidget {
  const Fillters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topbarWidget(),
              const SizedBox(height: 20),
              categoryItemWidget(context),
              const SizedBox(height: 5),
              levelItemWidget(context),
              const SizedBox(height: 5),
              priceItemWidget(context),
              const SizedBox(height: 5),
              featuresItemWidget(context),
              const SizedBox(height: 5),
              ratingItemWidget(context),
              const SizedBox(height: 5),
              videoDurationItemWidget(context),
              const SizedBox(height: 10),
              applyElevatedButton(),
            ],
          ),
        ),
      )),
    );
  }
}

Widget topbarWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            'Filters',
            style: headingFontStyle.copyWith(fontSize: 21),
          ),
        ],
      ),
      Text(
        'Clear',
        style:
            headingFontStyle.copyWith(fontSize: 16, color: fontSecondaryColor),
      )
    ],
  );
}

Widget categoryItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SubCategories:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('3D Design ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget levelItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Levels:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('All Level ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget priceItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Price:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('Paid ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget featuresItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Features:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('Coding ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget ratingItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Rating:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('4.5 & Up Above ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget videoDurationItemWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Video Durations:',
        style: headingFontStyle.copyWith(fontSize: 18),
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          RxBool value = false.obs;
          return Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: value.value,
                  onChanged: (bool? newValue) {
                    value.value = newValue ?? false;
                  },
                ),
                Text('4.5 & Up Above ${index + 1}', style: categoryFontStyle),
              ],
            );
          });
        },
      )
    ],
  );
}

Widget applyElevatedButton() {
  return Center(
    child: SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Apply',
          style: headingFontStyle.copyWith(fontSize: 18),
        ),
      ),
    ),
  );
}
