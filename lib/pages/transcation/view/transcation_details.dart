import 'dart:developer';

import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranscationDetails extends StatefulWidget {
  const TranscationDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TranscationDetailsState createState() => _TranscationDetailsState();
}

class _TranscationDetailsState extends State<TranscationDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  RxBool isTab = false.obs;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                Row(
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
                          'E-Receipt',
                          style: headingFontStyle.copyWith(fontSize: 21),
                        ),
                      ],
                    ),
                    PopupMenuButton<String>(
                      color: Colors.white,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController,
                      ),
                      onSelected: (String result) {
                        log(result);

                        isTab.value = false;
                        isTab.value
                            ? _animationController.forward()
                            : _animationController.reverse();
                      },
                      onOpened: () {
                        isTab.value = !isTab.value;
                        _animationController.forward();
                      },
                      onCanceled: () {
                        isTab.value = !isTab.value;
                        _animationController.reverse();
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'share',
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/icons/profiles/share_ic.png'),
                                const SizedBox(width: 10),
                                Text(
                                  'Share',
                                  style: headingTagFontStyle.copyWith(
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'download',
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/icons/inbox/download_ic.png'),
                                const SizedBox(width: 10),
                                Text(
                                  'Download',
                                  style: headingTagFontStyle.copyWith(
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'print',
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset('assets/icons/inbox/print_ic.png'),
                                const SizedBox(width: 10),
                                Text(
                                  'Print',
                                  style: headingTagFontStyle.copyWith(
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(child: Image.asset('assets/images/bill_img.png')),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset('assets/images/bar_code_img.png'),
                ),
                const SizedBox(height: 40),
                transactionDetailsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Name',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              'Krishnaprasad R',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email ID',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              'krishnaprasad.developer@gmail.com',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Course',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              '3d Character Illustration Cre..',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              'Web Development',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TransactionID',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              'SK345680976',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              '55.00',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Text(
              'Nov 20, 202X   /   15:45',
              style: descriptionFontStyle,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Status',
              style: headingFontStyle.copyWith(fontSize: 15),
            ),
            Container(
              width: 60,
              height: 20,
              color: componentsColor,
              child: Center(
                child: Text(
                  'Paid',
                  style: headingTagFontStyle.copyWith(
                      fontSize: 12, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
