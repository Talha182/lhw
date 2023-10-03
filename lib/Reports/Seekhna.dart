import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Seekhna extends StatefulWidget {
  Seekhna({super.key});

  @override
  State<Seekhna> createState() => _SeekhnaState();
}

class _SeekhnaState extends State<Seekhna> {
  String dropdownvalue = 'اس ہفتے';

// List of items in our dropdown menu
  var items = [
    'باب 1',
    'باب 2',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(
          '90-100%', 35, [const Color(0xffFE6C6C), const Color(0xffFE464B)]),
      ChartData(
          '70-80%', 23, [const Color(0xff7AD3FF), const Color(0xff4FBAF0)]),
      ChartData(
          '40-50%', 34, [const Color(0xffDCEFDE), const Color(0xff81C588)]),
      ChartData(
          '10-20%', 25, [const Color(0xffFCF4D9), const Color(0xffFDCD4F)]),
    ];

    final TooltipBehavior _tooltip;
    final List<_ChartData> data = [
      _ChartData('False', 12),
      _ChartData('True', 15),
    ];
    _tooltip = TooltipBehavior(enable: true);
    final List<Color> greenGradient = [
      const Color(0xffDCEFDE),
      const Color(0xff81C588),
    ];

    final List<Color> redGradient = [
      const Color(0xffFE6C6C),
      const Color(0xffFE464B),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const Text(
                "سیکھنے کا تجزیہ",
                style: TextStyle(
                    fontFamily: "UrduType",
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection
                            .rtl, // Set the text direction to right-to-left
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "کورس کی یاددہانی",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 17),
                                ),
                                Text(
                                  "کسی بھی شروع شدہ کورسز میں میری پیشرفت کے بارے میں مجھے مطلع کریں۔",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 13,
                                      color: Color(0xff8B9DA0)),
                                  textAlign: TextAlign
                                      .right, // Align text to the right
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'باب 1',
                                          style: TextStyle(
                                              fontFamily: 'UrduType',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 40,
                                    width: 70,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xff685F78)),
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                    ),
                                    iconSize: 14,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(20),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 270,
                              child: PieChart(
                                PieChartData(
                                  startDegreeOffset: 40,
                                  sections: getSections(),
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 60,
                                ),
                              ),
                            ),
                            Container(
                              height: 110,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey.shade100)),
                              child: const Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "85%",
                                      style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 15,
                                          color: Color(0xff454459)),
                                    ),
                                    Text(
                                      "Average Score",
                                      style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 10,
                                          color: Color(0xff454459)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 70,
                              left:
                                  50, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    40, 40), // Adjust this size as needed.
                                painter: LinePainter(),
                              ),
                            ),
                            Positioned(
                              top: 200,
                              left:
                                  70, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    40, 40), // Adjust this size as needed.
                                painter: Line2(),
                              ),
                            ),
                            Positioned(
                              top: 210,
                              right:
                                  90, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    40, 40), // Adjust this size as needed.
                                painter: Quiz3Line(),
                              ),
                            ),
                            Positioned(
                              top: 160,
                              right:
                                  60, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    35, 35), // Adjust this size as needed.
                                painter: Quiz2Line(),
                              ),
                            ),
                            Positioned(
                              top: 160,
                              right:
                                  60, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    35, 35), // Adjust this size as needed.
                                painter: Quiz2Line(),
                              ),
                            ),
                            Positioned(
                              top: 90,
                              right:
                                  70, // Adjust this to position the line correctly.
                              child: CustomPaint(
                                size: const Size(
                                    35, 35), // Adjust this size as needed.
                                painter: Quiz1Line(),
                              ),
                            ),
                            const Positioned(
                                top: 40,
                                left: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      "85%",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 15),
                                    ),
                                    Text(
                                      "Quiz 5",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 12),
                                    ),
                                  ],
                                )),
                            const Positioned(
                                top: 40,
                                right: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      "85%",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 15),
                                    ),
                                    Text(
                                      "Quiz 1",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 12),
                                    ),
                                  ],
                                )),
                            const Positioned(
                                top: 130,
                                right: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      "10%",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 15),
                                    ),
                                    Text(
                                      "Quiz 2",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 12),
                                    ),
                                  ],
                                )),
                            const Positioned(
                                top: 210,
                                right: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      "80%",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 15),
                                    ),
                                    Text(
                                      "Quiz 3",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 12),
                                    ),
                                  ],
                                )),
                            const Positioned(
                                top: 170,
                                left: 10,
                                child: Column(
                                  children: [
                                    Text(
                                      "95%",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 15),
                                    ),
                                    Text(
                                      "Quiz 4",
                                      style: TextStyle(
                                          fontFamily: "UrduType", fontSize: 12),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Directionality(
                            textDirection: TextDirection
                                .rtl, // Set the text direction to right-to-left
                            child: Text(
                              "بہترین اور بدترین اسکور",
                              style: TextStyle(
                                  fontFamily: "UrduType", fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Directionality(
                            textDirection: TextDirection
                                .rtl, // Set the text direction to right-to-left
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(colors: [
                                        Color(0xff99FFA3),
                                        Color(0xff68EE76),
                                      ])),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "بہترین اور صحت اسکور",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 15,
                                      color: Color(0xff685F78)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "95/100",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 18,
                                      color: Color(0xff59AD77)),
                                ),
                              ],
                            )),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Directionality(
                            textDirection: TextDirection
                                .rtl, // Set the text direction to right-to-left
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(colors: [
                                        Color(0xffFE6C6C),
                                        Color(0xffFE464B),
                                      ])),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "بہترین اور صحت اسکور",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 15,
                                      color: Color(0xff685F78)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "95/100",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 18,
                                      color: Color(0xffFE464B)),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 330,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection
                            .rtl, // Set the text direction to right-to-left
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "سکور کی تقسیم",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 17),
                                ),
                                Text(
                                  "تمام ابواب کے لیے اپنے سکور کی حدیں دیکھیں",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 13,
                                      color: Color(0xff8B9DA0)),
                                  textAlign: TextAlign
                                      .right, // Align text to the right
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'باب 1',
                                          style: TextStyle(
                                              fontFamily: 'UrduType',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 40,
                                    width: 70,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xff685F78)),
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                    ),
                                    iconSize: 14,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(20),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 220,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              axisLine: const AxisLine(
                                  width: 0.2), // Clean x-axis line
                              majorTickLines: const MajorTickLines(
                                  width: 0), // Hide x-axis tick lines
                              labelStyle: const TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 16,
                                  color: Color(0xff685F78))),
                          primaryYAxis: NumericAxis(
                              opposedPosition: true,
                              majorGridLines: MajorGridLines(
                                width: 0.5,
                                color: Colors.grey[300],
                                dashArray: [5, 5],
                              ),
                              axisLine: const AxisLine(width: 0.5),
                              majorTickLines: const MajorTickLines(width: 0),
                              labelStyle: const TextStyle(
                                  fontSize: 0), // This hides the y-axis labels
                              title: AxisTitle(
                                  text: 'اسکور کی حد',
                                  textStyle: const TextStyle(
                                    // Customize the title style if required
                                    color: Color(0xff8B9DA0),
                                    fontFamily: "UrduType",
                                    fontSize: 13,
                                  ))),
                          series: <ChartSeries<ChartData, String>>[
                            ScatterSeries<ChartData, String>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelMapper: (ChartData data, _) =>
                                  '', // Empty label but we'll use it for custom painting
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  labelAlignment:
                                      ChartDataLabelAlignment.middle,
                                  color: Colors.transparent,
                                  builder: (dynamic data,
                                      dynamic point,
                                      dynamic series,
                                      int pointIndex,
                                      int seriesIndex) {
                                    // assuming data is of type ChartData
                                    ChartData chartData = data as ChartData;

                                    return Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: chartData.gradientColors,
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    );
                                  }),

                              markerSettings: const MarkerSettings(
                                  isVisible: false), // Hide default markers
                            )
                          ],
                        ),
                      ),
                      const Center(
                        child: Text(
                          "اسکور کی حد",
                          style: TextStyle(
                              fontFamily: "UrduType", color: Color(0xff8B9DA0)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 330,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection
                            .rtl, // Set the text direction to right-to-left
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "درست بمقابلہ غلط",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 17),
                                ),
                                Text(
                                  "معلوم کریں کہ ہر کورس میں آپ کو کتنے سوالات صحیح/غلط ملے",
                                  style: TextStyle(
                                      fontFamily: "UrduType",
                                      fontSize: 13,
                                      color: Color(0xff8B9DA0)),
                                  textAlign: TextAlign
                                      .right, // Align text to the right
                                ),
                              ],
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: const Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'باب 1',
                                          style: TextStyle(
                                              fontFamily: 'UrduType',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontFamily: 'UrduType',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 40,
                                    width: 70,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xff685F78)),
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                    ),
                                    iconSize: 14,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 100,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(20),
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: 220,
                          child: SfCartesianChart(

                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                                opposedPosition: true,
                                majorGridLines: MajorGridLines(
                                  width: 0.5,
                                  color: Colors.grey[300],
                                  dashArray: [5, 5],
                                ),
                                axisLine: const AxisLine(
                                    width: 0.2 ), // Clean x-axis line
                                majorTickLines: const MajorTickLines(
                                    width: 0), // Hide x-axis tick lines
                                labelStyle: const TextStyle(
                                    fontFamily: "UrduType",
                                    fontSize: 16,
                                    color: Color(0xff685F78))),
                            primaryYAxis: NumericAxis(
                              opposedPosition: false,
                              majorGridLines: MajorGridLines(
                                width: 0.5,
                                color: Colors.grey[300],
                                dashArray: [5, 5],
                              ),
                              axisLine: const AxisLine(width: 0.5),
                              majorTickLines: const MajorTickLines(width: 0),
                              labelStyle: const TextStyle(
                                  fontSize: 10), // This hides the y-axis labels
                            ),
                            tooltipBehavior: _tooltip,
                            series: <ChartSeries<_ChartData, String>>[
                              BarSeries<_ChartData, String>(

                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  dataSource: data,
                                  xValueMapper: (_ChartData data, _) => data.x,
                                  yValueMapper: (_ChartData data, _) => data.y,
                                  pointColorMapper: (_ChartData data, _) {
                                    if (data.x == 'False') {
                                      // Use the gradient colors directly - might not be gradient but a solid color.
                                      return Colors.red[400];
                                    } else if (data.x == 'True') {
                                      return Colors.green[400];
                                    }
                                    return Colors
                                        .blue; // default color if neither of the above conditions are met.
                                  })
                            ],
                          )),
                      const Center(
                        child: Text(
                          "اسکور کی حد",
                          style: TextStyle(
                              fontFamily: "UrduType", color: Color(0xff8B9DA0)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "طاقتیں",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 18),
                      ),
                      const Text(
                        "معلوم کریں کہ آپ کی طاقت کہاں تھی۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 15,
                            color: Color(0xff8B9DA0)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/vitamin.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "غذائیت",
                                style: TextStyle(
                                    fontFamily: "UrduType", fontSize: 18),
                              ),
                              Text(
                                "ماڈیول 4: وٹامن اے کی کمی",
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    fontSize: 15,
                                    color: Color(0xff8B9DA0)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/image26.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "غذائیت",
                                style: TextStyle(
                                    fontFamily: "UrduType", fontSize: 18),
                              ),
                              Text(
                                "ماڈیول 4: وٹامن اے کی کمی",
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    fontSize: 15,
                                    color: Color(0xff8B9DA0)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/breastfeeding.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "غذائیت",
                                style: TextStyle(
                                    fontFamily: "UrduType", fontSize: 18),
                              ),
                              Text(
                                "ماڈیول 4: وٹامن اے کی کمی",
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    fontSize: 15,
                                    color: Color(0xff8B9DA0)),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> generateGradientSections({
  required String title,
  required double value,
  required Color startColor,
  required Color endColor,
  required double radius,
  int steps = 12,
}) {
  final List<PieChartSectionData> gradientSections = [];
  for (int i = 0; i < steps; i++) {
    final double r =
        startColor.red + (endColor.red - startColor.red) * (i / (steps - 1));
    final double g = startColor.green +
        (endColor.green - startColor.green) * (i / (steps - 1));
    final double b =
        startColor.blue + (endColor.blue - startColor.blue) * (i / (steps - 1));
    gradientSections.add(PieChartSectionData(
      title: i == steps ~/ 2 ? title : '',
      value: value / steps,
      color: Color.fromRGBO(r.round(), g.round(), b.round(), 1),
      radius: radius,
    ));
  }
  return gradientSections;
}

List<PieChartSectionData> getSections() {
  double gapValue = 0.4; // Adjust this to your preferred gap width

  final yellow = generateGradientSections(
    title: '',
    value: 40 - gapValue,
    startColor: const Color(0xffFFD572),
    endColor: const Color(0xffFEBD38),
    radius: 30,
  );

  final red = generateGradientSections(
    title: '',
    value: 10 - gapValue,
    startColor: const Color(0xffFE6C6C),
    endColor: const Color(0xffFE464B),
    radius: 20,
  );

  final blue = generateGradientSections(
    title: '',
    value: 25 - gapValue,
    startColor: const Color(0xff7AD3FF),
    endColor: const Color(0xff4FBAF0),
    radius: 25,
  );
  final green = generateGradientSections(
    title: '',
    value: 15 - gapValue,
    startColor: const Color(0xff99FFA3),
    endColor: const Color(0xff68EE76),
    radius: 20,
  );
  final pink = generateGradientSections(
    title: '',
    value: 25 - gapValue,
    startColor: const Color(0xffFD95D3),
    endColor: const Color(0xffFF5CBE),
    radius: 25,
  );
  return [
    ...pink,
    ...generateGap(gapValue),
    ...green,
    ...generateGap(gapValue),
    ...yellow,
    ...generateGap(gapValue),
    ...blue,
    ...generateGap(gapValue),
    ...red,
    ...generateGap(
        gapValue), // Remove this if you don't want a gap after the last section
  ];
}

List<PieChartSectionData> generateGap(double value) {
  return [
    PieChartSectionData(
      color: Colors.transparent,
      value: value,
      title: '',
      radius: 0,
      titleStyle: const TextStyle(fontSize: 0),
    )
  ];
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff454459)
          .withOpacity(0.5) // Or whichever color you want for the line.
      ..strokeWidth = 1.0;

    // Calculate the initial 60-degree line's end point.
    double length = size.height / 2; // Adjust as per your requirement.
    double x = length * sin(pi / 3);
    double y = length * cos(pi / 1);

    const Offset startPoint = Offset(0, 0);
    final Offset middlePoint = Offset(x, -y); // Negative y to go upwards.
    canvas.drawLine(startPoint, middlePoint, paint);

    // Draw horizontal line towards the label
    final Offset endPoint = Offset(size.width, middlePoint.dy);
    canvas.drawLine(middlePoint, endPoint, paint);

    // Draw a small circle at the end if needed.
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Line2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff454459)
          .withOpacity(0.5) // Or whichever color you want for the line.
      ..strokeWidth = 1.0;

    // Calculate the initial 60-degree line's end point.
    double length = size.height / 2; // Adjust as per your requirement.
    double x = length * sin(pi / 3);
    double y = length * cos(pi / 1);

    const Offset startPoint = Offset(-14, -5);
    final Offset middlePoint = Offset(x, y); // Negative y to go upwards.
    canvas.drawLine(startPoint, middlePoint, paint);

    // Draw horizontal line towards the label
    final Offset endPoint = Offset(size.width, middlePoint.dy);
    canvas.drawLine(middlePoint, endPoint, paint);

    // Draw a small circle at the end if needed.
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Quiz3Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff454459)
          .withOpacity(0.5) // Or whichever color you want for the line.
      ..strokeWidth = 1.0;

    // Calculate the initial 60-degree line's end point.
    double length = size.height / 2; // Adjust as per your requirement.
    double x = length * sin(pi / 3);
    double y = length * cos(pi / 3); // Fixed the cosine value.

    // Start point remains at the right-most side for this case.
    final Offset startPoint = const Offset(70, 15);
    final Offset middlePoint =
        Offset(size.width - x, -y); // Invert x and Negative y to go upwards.
    canvas.drawLine(startPoint, middlePoint, paint);

    // Draw horizontal line towards the label on the left.
    final Offset endPoint = Offset(0, middlePoint.dy);
    canvas.drawLine(middlePoint, endPoint, paint);

    // Draw a small circle at the end if needed.
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Quiz2Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff454459)
          .withOpacity(0.5) // Or whichever color you want for the line.
      ..strokeWidth = 1.0;

    // Calculate the initial 60-degree line's end point.
    double length = size.height / 2; // Adjust as per your requirement.
    double x = length * sin(pi / 3);
    double y = length * cos(pi / 3); // Fixed the cosine value.

    // Start point remains at the right-most side for this case.
    final Offset startPoint = const Offset(50, -5);
    final Offset middlePoint =
        Offset(size.width - x, y); // Invert x and Negative y to go upwards.
    canvas.drawLine(startPoint, middlePoint, paint);

    // Draw horizontal line towards the label on the left.
    final Offset endPoint = Offset(0, middlePoint.dy);
    canvas.drawLine(middlePoint, endPoint, paint);

    // Draw a small circle at the end if needed.
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Quiz1Line extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff454459)
          .withOpacity(0.5) // Or whichever color you want for the line.
      ..strokeWidth = 1.0;

    // Calculate the initial 60-degree line's end point.
    double length = size.height / 2; // Adjust as per your requirement.
    double x = length * sin(pi / 3);
    double y = length * cos(pi / 3); // Fixed the cosine value.

    // Start point remains at the right-most side for this case.
    final Offset startPoint = const Offset(50, -5);
    final Offset middlePoint =
        Offset(size.width - x, y); // Invert x and Negative y to go upwards.
    canvas.drawLine(startPoint, middlePoint, paint);

    // Draw horizontal line towards the label on the left.
    final Offset endPoint = Offset(0, middlePoint.dy);
    canvas.drawLine(middlePoint, endPoint, paint);

    // Draw a small circle at the end if needed.
    canvas.drawCircle(endPoint, 2.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ChartData {
  final String x;
  final int y;
  final List<Color> gradientColors; // Colors for the linear gradient

  ChartData(this.x, this.y, this.gradientColors);
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
