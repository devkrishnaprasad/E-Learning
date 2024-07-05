import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:flutter_share/flutter_share.dart';

// ignore: must_be_immutable
class CertificatePage extends StatelessWidget {
  final String username;
  final String courseName;

  CertificatePage({
    super.key,
    required this.username,
    required this.courseName,
  });
  var containerHeigh = 0.0;
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    containerHeigh = MediaQuery.of(context).size.height * 0.7;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final pdfFile = await generateAndSavePDF();
            await sharePDF(pdfFile.path);
          },
          label: Text(
            'Download Certificate',
            style: headingFontStyle.copyWith(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                    'Course certificate',
                    style: headingFontStyle.copyWith(fontSize: 21),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              certificateContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget certificateContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/LOGO.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  'Certificate of Completions',
                  style: headingFontStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'This Certifies that',
                  style: headingTagFontStyle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 15),
                Text(
                  username,
                  style: headingTagFontStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Has Successfully Completed the Wallace Training Program, Entitled.',
                    style: headingTagFontStyle.copyWith(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: AutoSizeText(
                    maxLines: 4,
                    courseName,
                    style: headingTagFontStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Issued on ${helperController.completedCourseDetails[0].completionDate}',
                  style: headingTagFontStyle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 15),
                Text(
                  'ID: SK24568086',
                  style: headingTagFontStyle.copyWith(
                      fontSize: 13, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Positioned(
            top: -1,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                'assets/images/right_corner.png',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/left_corner.png',
            ),
          ),
        ],
      ),
    );
  }

  Future<File> generateAndSavePDF() async {
    final pdf = pw.Document();
    final pdfTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
          await rootBundle.load('assets/fonts/OpenSans-Regular.ttf')),
      bold:
          pw.Font.ttf(await rootBundle.load('assets/fonts/OpenSans-Bold.ttf')),
    );
    final logoImage = await rootBundle.load('assets/images/LOGO.png');
    final logoBytes = logoImage.buffer.asUint8List();

    final leftImage = await rootBundle.load('assets/images/left_corner.png');
    final leftBytes = leftImage.buffer.asUint8List();

    final rightImage = await rootBundle.load('assets/images/right_corner.png');
    final rightBytes = rightImage.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        theme: pdfTheme,
        build: (pw.Context context) {
          return pw.Container(
            width: double.infinity,
            height: containerHeigh,
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(15),
              boxShadow: const [
                pw.BoxShadow(
                  color: PdfColors.grey500,
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ],
              color: PdfColors.white,
            ),
            child: pw.Stack(
              children: [
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 40),
                      pw.Image(
                        pw.MemoryImage(logoBytes),
                        width: 100,
                        height: 100,
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'Certificate of Completions',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        'This Certifies that',
                        style: const pw.TextStyle(fontSize: 13),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        'KrishnaPrasad R',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20, right: 20),
                        child: pw.Text(
                          'Has Successfully Completed the Wallace Training Program, Entitled.',
                          style: const pw.TextStyle(fontSize: 13),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        '3D Design Illustration Course',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        'Issued on November 24, 2022',
                        style: const pw.TextStyle(fontSize: 13),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text(
                        'ID: SK24568086',
                        style: pw.TextStyle(
                          fontSize: 13,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Positioned(
                  top: -1,
                  right: 0,
                  child: pw.ClipRRect(
                    horizontalRadius: 15,
                    verticalRadius: 15,
                    child: pw.Image(
                      pw.MemoryImage(rightBytes),
                    ),
                  ),
                ),
                pw.Positioned(
                  bottom: 0,
                  left: 0,
                  child: pw.Image(
                    pw.MemoryImage(leftBytes),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/certificate.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> sharePDF(String filePath) async {
    await FlutterShare.shareFile(
      title: 'Download Certificate',
      filePath: filePath,
    );
  }
}
