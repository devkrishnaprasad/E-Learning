import 'package:e_learn/pages/category/category.dart';
import 'package:e_learn/pages/courses/controller/courses_controller.dart';
import 'package:e_learn/pages/courses/view/all_courses.dart';
import 'package:e_learn/pages/courses/view/course_details/course_details.dart';
import 'package:e_learn/pages/courses/view/popular_courses.dart';
import 'package:e_learn/pages/filter/filters.dart';
import 'package:e_learn/pages/components/cards/course_card.dart';
import 'package:e_learn/pages/components/cards/offers_card.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/services/helper/local_storage/local_storage.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  LocalStorage localStorage = LocalStorage();
  CoursesController coursesController = Get.put(CoursesController());
  HelperController helperController = Get.find();
  RxString selectedCategoryId = ''.obs;
  RxInt currentIndex = 0.obs;
  RxList courseList = [].obs;

  @override
  Widget build(BuildContext context) {
    courseList.value = helperController.allPopularCoursesList;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () {
              return SingleChildScrollView(
                child: helperController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appBar(),
                          const SizedBox(height: 40),
                          searchField(),
                          const SizedBox(height: 30),
                          if (helperController.allBannerList.isNotEmpty)
                            offerCardWidget(context),
                          const SizedBox(height: 20),
                          categoryWidget(context),
                          const SizedBox(height: 40),
                          poluparCourses(),
                          const SizedBox(height: 30),
                          courseCardWdiget(context),
                          const SizedBox(height: 30),
                          mentorWidget(context),
                        ],
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              helperController.userFullName.value,
              style: headingFontStyle,
            ),
            Text('What would you like to learn today?',
                style: descriptionFontStyle),
            Text('Search below.', style: descriptionFontStyle)
          ],
        ),
        Image.asset('assets/icons/notification_ic.png')
      ],
    );
  }

  Widget searchField() {
    return TextFormField(
      onTap: () {},
      decoration: InputDecoration(
        hintText: 'Search for..',
        prefixIcon: Image.asset('assets/icons/search_ic.png'),
        suffixIcon: IconButton(
            onPressed: () {
              helperController.getAllCoursesList();
              Get.to(const Fillters());
            },
            icon: Image.asset('assets/icons/filter_ic.png')),
      ),
    );
  }

  Widget offerCardWidget(context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = helperController.allBannerList[index];
            return OffersCards(
              discount: '${data.amount}% Off*',
              title: data.title,
              description: data.description,
              imagePath: data.bannerImage,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 40);
          },
          itemCount: helperController.allBannerList.length),
    );
  }

  Widget categoryWidget(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: headingFontStyle.copyWith(fontSize: 18),
            ),
            GestureDetector(
              onTap: () {
                Get.to(Categorys());
              },
              child: Row(
                children: [
                  Text(
                    "SEE ALL",
                    style: headingTagFontStyle.copyWith(color: primaryColor),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: primaryColor,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(AllCourses());
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: componentsColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Center(
                        child: Text(
                            helperController
                                .allCourseCategooryList[index].categoryName,
                            style: descriptionFontStyle.copyWith(
                                color: overlayColor)),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 20);
              },
              itemCount: helperController.allCourseCategooryList.length),
        )
      ],
    );
  }

  Widget poluparCourses() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Polupar Courses',
              style: headingFontStyle.copyWith(fontSize: 18),
            ),
            GestureDetector(
              onTap: () {
                Get.to(PopularCourses());
              },
              child: Row(
                children: [
                  Text(
                    "SEE ALL",
                    style: headingTagFontStyle.copyWith(color: primaryColor),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: primaryColor,
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        categoryLsit(),
      ],
    );
  }

  Widget categoryLsit() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                courseList.value = helperController.allPopularCoursesList;
                currentIndex.value = index;
              } else {
                courseList.value = helperController.allPopularCoursesList
                    .where((course) =>
                        course.productCategory ==
                        helperController
                            .allCourseCategooryList[index - 1].categoryId)
                    .toList();
                currentIndex.value = index;
              }
            },
            child: Obx(
              () {
                return Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: currentIndex.value == index
                        ? componentsColor
                        : cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      index == 0
                          ? 'All'
                          : helperController
                              .allCourseCategooryList[index - 1].categoryName,
                      style: TextStyle(
                        fontSize: 13,
                        color: currentIndex.value == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 5);
        },
        itemCount: helperController.allCourseCategooryList.length +
            1, // +1 for the "All" category
      ),
    );
  }

  Widget courseCardWdiget(context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var data = courseList[index];

            return GestureDetector(
              onTap: () {
                bool status = helperController.purchaseDetails
                    .where((product) => product.productId == data.productId)
                    .isNotEmpty;
                coursesController.getCourseDetails(data.productId);
                coursesController.getProductReview(data.productId);

                Get.to(CourseDetails(
                  isPurchased: status,
                ));
              },
              child: CourseCard(
                imageUrl: data.productImage,
                title: data.productName,
                subtitle: data.about,
                price: '₹${data.price}',
                rating: data.rating,
                studentCount: '${data.studentsCount} Std',
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20);
          },
          itemCount: courseList.length),
    );
  }

  Widget mentorWidget(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Mentor',
              style: headingFontStyle.copyWith(fontSize: 18),
            ),
            Row(
              children: [
                Text(
                  "SEE ALL",
                  style: headingTagFontStyle.copyWith(color: primaryColor),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: primaryColor,
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/mentor_img.png',
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
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
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Jensen',
                      style: headingTagFontStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10);
              },
              itemCount: 10),
        )
      ],
    );
  }
}
