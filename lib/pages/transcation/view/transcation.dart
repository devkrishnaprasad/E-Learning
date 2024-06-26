import 'package:e_learn/pages/transcation/view/transcation_details.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transcation extends StatelessWidget {
  const Transcation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions',
                      style: headingFontStyle.copyWith(fontSize: 21),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/search_ic.png'))
                  ],
                ),
                const SizedBox(height: 10),
                transactionCard()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionCard() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(TranscationDetails());
            },
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/course_img.jpeg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Build Personal Branding',
                          style: headingFontStyle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Web Designer',
                          style: headingTagFontStyle.copyWith(fontSize: 13),
                        ),
                        const SizedBox(height: 5),
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
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: 20);
  }
}
