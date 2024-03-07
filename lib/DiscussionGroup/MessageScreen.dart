import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:collection';

import 'package:get/get.dart';

import 'Messaging_Settings.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Variable
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTextEmpty = true;
  bool _showTime = true;
  Message? _replyingMessage;
  final List<Message> _messages = [];
  FocusNode _messageFocusNode = FocusNode();
  String hintText = "کچھ ٹائپ کریں...";

  bool showSuggestions = false;
  List<String> demoUsers = [
    "Alice",
    "Bob",
    "Charlie",
    "David",
  ];
  List<String> allUsers = [
    'علی',
    'احمد',
    'سارہ',
    'فاطمہ',
    'حسان',
    'زینب',
    'عمر',
    'حفصہ',
    'طارق',
    'رابیہ'
  ];

  List<String> filteredUsers = [];

  // Methods
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_handleTextChange);

    _textEditingController.addListener(() {
      setState(() {
        _isTextEmpty = _textEditingController.text.isEmpty;
      });
    });

    // Add a default message from another user
    _messages.add(Message(
        text: "سلام، کس طرح ہیں آپ?",
        isCurrentUser: false,
        timestamp: DateTime.now()));
  }

  _handleTextChange() {
    bool containsAtSymbol = _textEditingController.text.contains("@");
    if (containsAtSymbol && !showSuggestions) {
      setState(() {
        showSuggestions = true;
      });
    } else if (!containsAtSymbol && showSuggestions) {
      setState(() {
        showSuggestions = false;
      });
    }
  }

  void _sendMessage() {
    String trimmedMessage = _textEditingController.text.trim();
    if (trimmedMessage.isNotEmpty) {
      bool isThisMessageAQuestion = hintText == "سوال";

      setState(() {
        _messages.add(Message(
            text: trimmedMessage,
            isCurrentUser: true,
            timestamp: DateTime.now(),
            showTime: _showTime,
            isQuestion: isThisMessageAQuestion,  // Add this line
            repliedTo: _replyingMessage
        ));
        _showTime = false;

        // Resetting the hintText after sending the message.
        if (isThisMessageAQuestion) {
          hintText = "کچھ ٹائپ کریں...";
        }

        _textEditingController.clear();
      });
      _scrollToBottom();
    }
  }


  OverlayEntry? overlayEntry;

  void _showAttachmentOptions() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
      return; // if overlay is already shown, hide it and exit.
    }

    overlayEntry = OverlayEntry(
      builder: (context) {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return Stack(
          children: [
            // Capture taps outside the overlay:
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  overlayEntry!.remove();
                  overlayEntry = null;
                },
                child: const Material(
                  color: Colors.transparent, // use transparent color to capture taps
                ),
              ),
            ),

            // The overlay content:
            Positioned(
              bottom: keyboardHeight > 0 ? keyboardHeight + 50 : 54,
              right: 95,
              child: Material(
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              hintText = "سوال";
                            });
                            overlayEntry!.remove();
                            overlayEntry = null;
                          },
                          child: const Row(
                            children: [
                              Text(
                                "بطور سوال بھیجیں۔",
                                style: TextStyle(
                                  fontFamily: "UrduType",
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.help_outline_rounded),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10,),
                        const Row(
                          children: [
                            Text("منسلکہ",style: TextStyle(
                                fontFamily: "UrduType"
                            ),),
                            SizedBox(width: 10,),
                            Icon(Icons.attachment_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const MessageSettings());
                    },
                      child: SvgPicture.asset("assets/images/Icon.svg")),
                  const Text(
                    "ترتیبات",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_forward, color: Colors.black),
                    onTap: () {
                      // Add your navigation logic here
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (message.isCurrentUser &&
                        details.primaryVelocity! < 50) {
                      setState(() {
                        _replyingMessage = message;
                      });
                    } else if (!message.isCurrentUser &&
                        details.primaryVelocity! > -50) {
                      setState(() {
                        _replyingMessage = message;
                      });
                    }
                    // Add the following line to request focus:
                    _messageFocusNode.requestFocus();
                  },
                  child: Column(
                    children: [
                      if (message.showTime)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            convertToUrduDate(message
                                .timestamp), // Assuming you have this function implemented
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "UrduType",
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),


                      if (message.isCurrentUser)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(

                            children: [

                              if (message.repliedTo != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(children: [
                                        RoundedEndDivider(
                                            thickness: 4, length: 25),
                                        Container(
                                          //Replied to container
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: Text(message.repliedTo!.text,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: "UrduType",
                                                fontSize: 12,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            if (message.isQuestion)
                                                 const Text(
                                                  "سوال",
                                                  style: TextStyle(
                                                    color: Color(0xffA0A0A0),
                                                    fontFamily: "UrduType",
                                                  ),
                                                   textAlign: TextAlign.left,
                                                ),
                                             Text(message.text,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "UrduType")),
                                          ],
                                        ),

                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile_pic.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              if (message.repliedTo != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Row(
                                        children: [
                                          RoundedEndDivider(
                                              thickness: 4, length: 25),
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: Text(message.repliedTo!.text,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "UrduType",
                                                  fontSize: 12,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 12,
                                      backgroundImage:
                                          AssetImage('assets/images/2.png'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.grey[300],
                                      ),
                                      child: Text(
                                        message.text,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "UrduType"),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          if (_replyingMessage != null)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _replyingMessage = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 10, bottom: 10),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "انیما اگروال کا جواب",
                              style: TextStyle(
                                  fontFamily: "UrduType", fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Flexible(
                              child: Text(
                                _replyingMessage!.text,
                                softWrap: true,
                                style: const TextStyle(
                                    fontFamily: "UrduType", fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          Container(
            color: const Color(0xffF5F5F5) ,
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        // Check for @ symbol
                        if (text.contains('@')) {
                          String query = text
                              .split('@')
                              .last
                              .toLowerCase(); // Convert the query to lowercase

                          if (query.isEmpty) {
                            filteredUsers =
                                allUsers; // If nothing after '@', show all users.
                          } else {
                            // Filter the users based on the query (case-insensitive)
                            filteredUsers = allUsers
                                .where((user) => user
                                .toLowerCase()
                                .startsWith(query))
                                .toList();
                          }
                          setState(() {
                            showSuggestions = true;
                          });
                        } else {
                          setState(() {
                            showSuggestions = false;
                          });
                        }
                      },
                      focusNode: _messageFocusNode,
                      controller: _textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline, // Facilitates easy multiline input

                      cursorColor: Colors.black.withOpacity(0.7),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        hintText: hintText,
                        hintStyle: const TextStyle(fontFamily: "UrduType", color: Color(0xffA0A0A0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  Container(
                    // Adjust padding as needed
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _sendMessage();
                              _replyingMessage = null;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isTextEmpty ? Colors.grey : const Color(0xffFE8BD1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2, right: 2),
                              child: SvgPicture.asset("assets/images/send.svg", fit: BoxFit.scaleDown),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _showAttachmentOptions();
                          },
                          child: SvgPicture.asset("assets/images/attachment.svg"),
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset("assets/images/microphone.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSuggestionsBox() {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true, // constrain the height
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: ClipOval(
                    child: Image.asset("assets/images/profile_pic.png")),
              ),
              title: Text(
                filteredUsers[index],
                style: const TextStyle(fontFamily: "UrduType"),
              ),
              onTap: () {
                final user =
                    filteredUsers[index]; // Fetch user from filteredUsers
                final currentText = _textEditingController.text;
                final lastIndex = currentText.lastIndexOf('@');
                final newText = currentText.substring(0, lastIndex) + '$user@ ';
                _textEditingController.text = newText;
                _textEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: newText.length));
                setState(() {
                  showSuggestions = false;
                });
              },
            );
          },
        ),
      ),
    );
  }
}

// void _showAttachmentOptions(BuildContext context) {
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: 120,  // or whatever height you want
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.question_answer),
//                 title: Text('Send as a question'),
//                 onTap: () {
//                   // Handle the action for "Send as a question"
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.insert_drive_file),
//                 title: Text('Documents'),
//                 onTap: () {
//                   // Handle the action for "Documents"
//                 },
//               ),
//             ],
//           ),
//         );
//       }
//   );
// }

class Message {
  final String text;
  final bool isCurrentUser;
  final DateTime timestamp;
  final bool showTime;
  final Message? repliedTo;
  final bool isQuestion;  // add this


  Message({
    required this.text,
    required this.isCurrentUser,
    required this.timestamp,
    this.showTime = false,
    this.repliedTo,
    this.isQuestion = false,  // default it to false

  });
}

String convertToUrduDate(DateTime dateTime) {
  final urduMonths = [
    "جنوری",
    "فروری",
    "مارچ",
    "اپریل",
    "مئی",
    "جون",
    "جولائی",
    "اگست",
    "ستمبر",
    "اکتوبر",
    "نومبر",
    "دسمبر"
  ];

  final day = dateTime.day;
  final monthName = urduMonths[dateTime.month - 1];
  final year = dateTime.year;
  final time =
      "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} بجے";

  return "$day $monthName $year - $time ";
}

class RoundedEndDivider extends StatelessWidget {
  final double thickness;
  final double length;

  RoundedEndDivider({
    required this.thickness,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RoundedEndPainter(thickness, length),
      size: Size(thickness, length),
    );
  }
}

class _RoundedEndPainter extends CustomPainter {
  final double thickness;
  final double length;

  _RoundedEndPainter(
    this.thickness,
    this.length,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffDBDBDB)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    canvas.drawLine(
      Offset(thickness / 2, 0),
      Offset(thickness / 2, length - thickness),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
