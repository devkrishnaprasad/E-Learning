import 'package:e_learn/pages/signin_sigin_up/signin_page.dart';
import 'package:e_learn/services/helper/local_storage/local_storage.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: headingFontStyle.copyWith(fontSize: 21),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: componentsColor,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: Text(
                            'K',
                            style:
                                TextStyle(fontSize: 40, color: componentsColor),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Image.asset(
                                'assets/icons/profiles/image_row.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: boxShadowColor,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Krishnaprasad R',
                            style: headingFontStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'krishnaprasad.developer@gmail.com',
                            style: descriptionFontStyle,
                          ),
                        ),
                        const SizedBox(height: 20),
                        menuListWidget(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(componentsColor),
                          ),
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                          child: Text(
                            'Logout',
                            style: headingFontStyle.copyWith(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuListWidget() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/user_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Edit Profile',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/wallet_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Payment Option',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/nootification_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Notifications',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/security_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Security',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/language_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Language',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/mode_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Dark Mode',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/policy_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Terms & Conditions',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/help_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Help Center',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icons/profiles/message_ic.png'),
                  const SizedBox(width: 15),
                  Text(
                    'Intive Friends',
                    style: descriptionFontStyle.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation', style: headingFontStyle),
          content: Text(
            'Are you sure you want to logout?',
            style: headingTagFontStyle.copyWith(fontSize: 15),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(boxShadowColor),
              ),
              child: Text(
                'No',
                style: headingTagFontStyle.copyWith(fontSize: 15),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                LocalStorage localStorage = LocalStorage();
                await localStorage.clearAllData();
                Get.deleteAll();
                Get.to(SignInPage());
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(componentsColor),
              ),
              child: Text(
                'Yes',
                style: headingTagFontStyle.copyWith(fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
