import 'dart:ui';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Settings/Samaji.dart';
import 'package:lhw/Settings/data.dart';

import 'Itla\'aat.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey _tabBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.5,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 50, // Added this to make the space equally spread
                    ),
                    const Text(
                      "سیٹنگز",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xff232323),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    GestureDetector(
                      child: const Icon(
                          Icons.arrow_forward, color: Colors.black),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: _tabBar(),
      ),
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                splashColor: Colors.transparent,
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                tabs: [
                  Tab(text: "سوشل میڈیا"),
                  Tab(text: "انٹرنیٹ اور وای فای"),
                  Tab(text: "اطلاعات "),
                ],
              ),

            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[

                SocialMediaScreen(),
                DataScreen(),
                ItlaatScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}