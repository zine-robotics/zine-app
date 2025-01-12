import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/components/poll_card.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

class PollCreatorScreen extends StatefulWidget {
  const PollCreatorScreen({super.key});

  @override
  State<PollCreatorScreen> createState() => _PollCreatorScreenState();
}

class _PollCreatorScreenState extends State<PollCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(
      builder: (context, chatVm, child) {
        return Scaffold(
            backgroundColor: backgroundGrey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              centerTitle: true,
              title: const Text(
                "Add Poll",
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              actions: [
                IconButton(
                  color: greyText,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
                const SizedBox(
                  width: 20.0,
                )
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0),
                ),
              ),
            ),
            body: PollCard());
      },
    );
  }
}
