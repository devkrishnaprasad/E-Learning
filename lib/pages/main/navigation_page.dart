import 'package:e_learn/pages/main/controller/navigation_controller.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});
  HelperController helperController = Get.find();
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: navigationController
              .children[navigationController.currentIndex.value],
        );
      }),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            showUnselectedLabels: true,
            onTap: (value) {
              navigationController.currentIndex.value = value;
            },
            currentIndex: navigationController.currentIndex.value,
            selectedItemColor: componentsColor,
            unselectedItemColor: Colors.black,
            selectedIconTheme: const IconThemeData(color: componentsColor),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/courses_ic.png')),
                label: 'My Courses',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/message_ic.png')),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/wallet_ic.png')),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/icons/user_ic.png')),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
