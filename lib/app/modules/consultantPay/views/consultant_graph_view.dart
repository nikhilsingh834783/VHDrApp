import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/consultantPay/controllers/consultant_pay_controller.dart';
import '../../../app_common_widgets/common_import.dart';

class ConsultantGraphView extends GetView<ConsultantPayController> {
  const ConsultantGraphView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConsultantPayController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: 'Consultant Pay',
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
        body: Padding(
          padding: EdgeInsets.only(
            top: Sizes.crossLength * 0.050,
            right: Sizes.crossLength * 0.020,
          ),
          child: AspectRatio(
            aspectRatio: 0.68,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: LineChart(
                LineChartData(
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.3),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withOpacity(0.3),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.px8,
                                  fontWeight: FontWeight.w400),
                            );
                          },
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 0.8),
                        right: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 0.8),
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2), width: 0.8),
                      ),
                    ),
                    minX: 0,
                    maxX: (controller.paymentStatus.length.toDouble()),
                    minY: 100000,
                    maxY: 1000000,
                    lineBarsData: [listChartData(controller: controller)]),
              ),
            ),
          ),
        ),
      );
    });
  }

  listChartData({required ConsultantPayController controller}) {
    {
      return LineChartBarData(
        spots: [
          for (int i = 0; i < controller.paymentStatus.length; i++)
            FlSpot(double.parse(i.toString()),
                double.parse(controller.paymentStatus[i].payment!)),
        ],
        isCurved: true,
        color: ConstColor.graphColor,
        barWidth: 6,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            if (index == barData.spots.length - 1) {
              return FlDotCirclePainter(
                radius: 10,
                color: ConstColor.whiteColor,
                strokeWidth: 6,
                strokeColor: ConstColor.graphColor,
              );
            } else {
              return FlDotCirclePainter(
                radius: 0,
                color: Colors.transparent,
                strokeWidth: 0,
                strokeColor: Colors.transparent,
              );
            }
          },
        ),
        belowBarData: BarAreaData(show: false),
      );
    }
  }
}
