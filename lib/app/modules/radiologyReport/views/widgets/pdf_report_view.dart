// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/radiology_report_controller.dart';

class RadiologyPdfView extends StatefulWidget {
  String url;
  RadiologyPdfView({super.key, required this.url});

  @override
  State<RadiologyPdfView> createState() => _RadiologyPdfViewState();
}

class _RadiologyPdfViewState extends State<RadiologyPdfView> {
  String? pdfUrl;
  @override
  void initState() {
    super.initState();
    pdfUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RadiologyReportController());
    return GetBuilder<RadiologyReportController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Radiology Reports',
              fontSize: Sizes.px22,
              fontColor: ConstColor.headingTexColor,
              fontWeight: FontWeight.w800,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
            excludeHeaderSemantics: false,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
          ),
          backgroundColor: Colors.white,
          // drawer: const MyDrawer(),
          body: Padding(
            padding: EdgeInsets.only(
              left: Sizes.crossLength * 0.020,
              right: Sizes.crossLength * 0.020,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
                pdfUrl != null && pdfUrl != ''
                    ? Expanded(
                        child: const PDF().cachedFromUrl(
                        pdfUrl!,
                        placeholder: (progress) =>
                            Center(child: Text('$progress %')),
                        errorWidget: (error) =>
                            Center(child: Text(error.toString())),
                      ))
                    : Expanded(
                        child: Center(
                        child: AppText(
                          text: "No reports found.",
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
              ],
            ),
          ),
        );
      },
    );
  }
}
