import 'package:e_learn/pages/home/view/home.dart';
import 'package:e_learn/pages/inbox/inbox.dart';
import 'package:e_learn/pages/my_courses/my_courses.dart';
import 'package:e_learn/pages/profile/profile.dart';
import 'package:e_learn/pages/transcation/transcation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final List<Widget> children = [
    const HomePage(),
    const MyCourses(),
    const Inbox(),
    const Transcation(),
    const Profile(),
  ];

  RxInt currentIndex = 0.obs;
}
