import 'package:e_learn/pages/inbox/view/chatview.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/theme/colors.dart';

// ignore: must_be_immutable
class Inbox extends StatelessWidget {
  Inbox({super.key});
  RxBool isChat = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Inbox',
                      style: headingFontStyle.copyWith(fontSize: 21),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/search_ic.png'))
                  ],
                ),
                const SizedBox(height: 20),
                toggleButton(context),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Obx(() {
                    return isChat.value ? chatCard(context) : callCard(context);
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget toggleButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            isChat.value = true;
          },
          child: Obx(
            () {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                    color: isChat.value ? componentsColor : secondaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Chat',
                    style: headingTagFontStyle.copyWith(
                        color: isChat.value ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            isChat.value = false;
          },
          child: Obx(
            () {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                    color: isChat.value ? secondaryColor : componentsColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Call',
                    style: headingTagFontStyle.copyWith(
                        color: !isChat.value ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget chatCard(context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(ChatView());
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 30),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Virginia M. Patterson',
                            style: headingFontStyle.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Hi, Good Evening Bro.!',
                            style: headingTagFontStyle.copyWith(fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '4',
                            style: headingTagFontStyle.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '14:59',
                        style: headingTagFontStyle.copyWith(fontSize: 11),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 10);
  }

  Widget callCard(context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(radius: 30),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Virginia M. Patterson',
                          style: headingFontStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset('assets/icons/inbox/incoming_ic.png'),
                            const SizedBox(width: 10),
                            Text(
                              'Incoming',
                              style: headingTagFontStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 2,
                              height: 15,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Nov 03, 202X',
                              style: headingTagFontStyle.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Image.asset('assets/icons/inbox/phone_ic.png')
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 10);
  }
}
