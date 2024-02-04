import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'Achievements.dart'; // Your import paths
import 'Sargarmi.dart'; // Your import paths
import 'Seekhna.dart'; // Your import paths

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: () {
              // Your navigation logic here
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffDCEFDE),
                                  Color(0xff81C588),
                                ])),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "سندھ میں لیڈر بورڈ رینک",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Color(0xff685F78)),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        fontSize: 25,
                                        color: Color(0xff002058)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffFCF4D9),
                                  Color(0xffFDCD4F),
                                ])),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "سندھ میں لیڈر بورڈ رینک",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Color(0xff685F78)),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        fontSize: 25,
                                        color: Color(0xff002058)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffE6ECF9),
                                  Color(0xff839EE2),
                                ])),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "60 گھنٹے گزارے۔",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Color(0xff685F78)),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      "60 گھنٹے گزارے۔",
                                      style: TextStyle(
                                        fontFamily: "UrduType",
                                        fontSize: 25,
                                        color: Color(0xff002058),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffF4B9E1),
                                  Color(0xffED8DCE),
                                ])),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "کوئز کی تازہ ترین کارکردگی",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        color: Color(0xff685F78)),
                                  ),
                                  Text(
                                    "90%",
                                    style: TextStyle(
                                        fontFamily: "UrduType",
                                        fontSize: 25,
                                        color: Color(0xff002058)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            const SizedBox(height: 20,),
            ButtonsTabBar(
              controller: _tabController,
              splashColor: Colors.transparent,
              height: 50,
              radius: 20,
              elevation: 1,
              contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              backgroundColor: Colors.white,
              unselectedBackgroundColor: const Color(0xffF0F0F0),
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'UrduType',
                  color: Color(0xff685F78),
                  fontWeight: FontWeight.w600),
              labelStyle: const TextStyle(
                  fontFamily: 'UrduType',
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "کامیابیاں"),
                Tab(text: "سرگرمی"),
                Tab(text: "سیکھنا"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const Achievements(),
                  const Sargarmi(),
                  Seekhna(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
