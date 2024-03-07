import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({Key? key}) : super(key: key);

  @override
  SocialMediaScreenState createState() => SocialMediaScreenState();
}

class SocialMediaScreenState extends State<SocialMediaScreen> {
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();

  bool wifiOnlyDownloads = false;
  bool shareCompletedCourses = false;
  bool shareAchievedBadges = false;
  bool shareLeaderboardRank = false;

  @override
  void dispose() {
    _linkedinController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            _buildSectionHeader("سوشل میڈیا"),
            _buildSectionSubHeader("فوری اور ای میل کی اطلاعات حاصل کرنے کا طریقہ چنیں۔"),
            const Divider(),
            _buildTextField("لنکڈن", _linkedinController),
            _buildTextField("فیس بک", _facebookController),
            _buildTextField("انسٹاگرام", _instagramController),
            _buildTextField("ٹویٹر", _twitterController),
            const Divider(),
            _buildSectionHeader("شیر سیٹنگ"),
            _buildSectionSubHeader("اپنے موبائل اور ڈیسک ٹاپ اطلاعات کا انتظام کریں۔"),
            _buildSwitchTile(
              "وائی فائی پر ڈاؤن لوڈ",
              "یونٹ کا مواد صرف وائی فائی پر ڈاؤن لوڈ کریں۔",
              wifiOnlyDownloads,
                  (bool newValue) {
                setState(() => wifiOnlyDownloads = newValue);
              },
            ),
            const Divider(),
            _buildSectionHeader("شیر سیٹنگ"),
            _buildSectionSubHeader("خود بخود شیئر ہونے والی چیزیں چنیں۔ "),
            _buildSwitchTile(
              "مکمل یونٹ",
              "",
              shareCompletedCourses,
                  (bool newValue) {
                setState(() => shareCompletedCourses = newValue);
              },
            ),
            _buildSwitchTile(
              "حاصل کردہ تمغے",
              "",
              shareAchievedBadges,
                  (bool newValue) {
                setState(() => shareAchievedBadges = newValue);
              },
            ),
            _buildSwitchTile(
              "مہارت پوزیشن",
              "",
              shareLeaderboardRank,
                  (bool newValue) {
                setState(() => shareLeaderboardRank = newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) => Text(
    text,
    style: const TextStyle(fontFamily: "UrduType", fontSize: 17),
    textAlign: TextAlign.right,
  );

  Widget _buildSectionSubHeader(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: const TextStyle(fontFamily: "UrduType", fontSize: 13, color: Color(0xff8B9DA0)),
      textAlign: TextAlign.right,
    ),
  );

  Widget _buildTextField(String label, TextEditingController controller) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
         Text(
          label,
          style: const TextStyle(fontFamily: "UrduType", fontSize: 15),
          textAlign: TextAlign.right, // Align text to the right
        ),
        const SizedBox(height: 10,),
        TextField(
          controller: controller,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: "URL درج کریں۔",
            hintStyle:
            const TextStyle(fontFamily: "UrduType", color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0), // Adjust vertical padding
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color(0xffCDD1E0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color(0xffCDD1E0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Color(0xffCDD1E0),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildSwitchTile(String title, String subtitle, bool stateValue,
      Function(bool) onChanged) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontFamily: "UrduType", fontSize: 17),
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              fontFamily: "UrduType", fontSize: 13, color: Color(0xff8B9DA0)),
          textAlign: TextAlign.right,
        ),
        trailing: Directionality(
          textDirection: TextDirection.ltr,
          child: CupertinoSwitch(
            activeColor: const Color(0xff72C391),
            value: stateValue,
            onChanged: onChanged,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
        onTap: () => onChanged(!stateValue),
      ),
    );
  }
}
