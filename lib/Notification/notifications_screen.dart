import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    // if (message == null) {
    //   // Handle the case when the message is null, maybe return to the previous screen with a message
    //   print("No notification");
    //   // For example, you can pop the screen and return to the previous one:
    //   Navigator.of(context).pop();
    //   return Container(); // or another widget as a placeholder
    // }

    final imageUrl = message?.data['imageUrl'];  // Now you can safely access data without "!"


    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                  child: GestureDetector(
                    child: const Text(
                      "پڑھا ہوا نشان زد کریں۔",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xffFE8BD1),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5, right: 40),
                  child: Text(
                    "اطلاعات",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_forward),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: message == null
          ? Center(
        child: Text(
          "No notifications",
          style: TextStyle(
            fontFamily: 'UrduType',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textDirection: TextDirection.rtl,
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const Text(
              "آج",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'UrduType',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
        Container(
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrl != null)
                  Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                else
                  SvgPicture.asset("assets/images/1.png"),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message!.notification!.title.toString(),
                        style: const TextStyle(
                          fontSize: 15.4,
                          fontFamily: "UrduType",
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        message!.notification!.body.toString(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "UrduType",
                          color: Color(0xff7A7D84),
                        ),
                        textAlign: TextAlign.justify,
                        ),
                      // ),Text(
                      //   message.data.toString(),
                      //   style: const TextStyle(
                      //     fontSize: 13,
                      //     fontFamily: "UrduType",
                      //     color: Color(0xff7A7D84),
                      //   ),
                      //   textAlign: TextAlign.justify,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.close)
              ],
            ),
          ),
        ),
            // const Text(
            //   "قبل ازیں",
            //   textDirection: TextDirection.rtl,
            //   style: TextStyle(
            //     fontFamily: 'UrduType',
            //     fontSize: 20,
            //     color: Colors.black,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification.svg",
            //   title:
            //       "آپ کو 'باب 9: نیوٹریشن' ڈسکشن گروپ میں شامل کیا گیا ہے۔ ابھی گفتگو میں شامل ہوں!",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),
            // const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification_alarm.svg",
            //   title:
            //       "&#39;انفینٹ کیئر&#39; پر آپ کے آخری سبق کو ایک ہفتہ ہو گیا ہے۔ آج اپنا سیکھنے کا سفر جاری رکھیں",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),
            // const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification_trophy.svg",
            //   title:
            //       "مبارک ہو! آپ لیڈر بورڈ پر 5ویں نمبر پر چلے گئے ہیں۔ چلتے رہو!",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),
            // const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification_badge.svg",
            //   title:
            //       "بہت اچھے! آپ نے &#39;ویکسینیشن ٹیکنیکس&#39; کورس کا 50% مکمل کر لیا ہے۔ اسے جاری رکھیں",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification_thumbsup.svg",
            //   title:
            //       "ہم آپ کے ان پٹ کی قدر کرتے ہیں! براہ کرم &#39;بنیادی حفظان صحت کے طریقوں&#39; کورس کے لیے رائے دیں۔",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),const SizedBox(
            //   height: 20,
            // ),
            // NotificationCard(
            //   imagePath: "assets/images/notification_settings.svg",
            //   title:
            //       "اچھی خبر! ہم نے سیکھنے کے آسان تجربے کے لیے ایپ کو اپ ڈیٹ کیا ہے۔",
            //   date: formatCurrentDateInUrdu(),
            // ),
            // const Divider(),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;

  const NotificationCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.4,
                      fontFamily: "UrduType",
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "UrduType",
                      color: Color(0xff7A7D84),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.close)
          ],
        ),
      ),
    );
  }
}

String formatCurrentDateInUrdu() {
  // Get the current date and split its components
  DateTime now = DateTime.now();
  String day = now.day.toString();
  String month = getUrduMonth(now.month);
  String year = now.year.toString();

  // Convert Arabic numerals to Urdu script
  String urduDay = arabicToUrduNumerals(day);
  // String urduYear = arabicToUrduNumerals(year);

  // Construct the formatted date in Urdu
  String formattedDate = '$urduDay $month ';

  return formattedDate;
}

String getUrduMonth(int month) {
  // Define a mapping of Arabic month numbers to Urdu month names
  Map<int, String> urduMonths = {
    1: 'جنوری',
    2: 'فروری',
    3: 'مارچ',
    4: 'اپریل',
    5: 'مئی',
    6: 'جون',
    7: 'جولائی',
    8: 'اگست',
    9: 'ستمبر',
    10: 'اکتوبر',
    11: 'نومبر',
    12: 'دسمبر',
  };

  return urduMonths[month] ?? '';
}

String arabicToUrduNumerals(String arabicNumerals) {
  // Define a mapping of Arabic numerals to Urdu numerals
  Map<String, String> urduNumeralsMap = {
    '0': '۰',
    '1': '۱',
    '2': '۲',
    '3': '۳',
    '4': '۴',
    '5': '۵',
    '6': '۶',
    '7': '۷',
    '8': '۸',
    '9': '۹',
  };

  // Convert Arabic numerals to Urdu numerals
  String urduNumerals = '';
  for (int i = 0; i < arabicNumerals.length; i++) {
    urduNumerals += urduNumeralsMap[arabicNumerals[i]] ?? arabicNumerals[i];
  }

  return urduNumerals;
}
