import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

class ReplyCard extends StatelessWidget {
  final ChatRoomViewModel chatVm;
  const ReplyCard({super.key, required this.chatVm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Replying to ${chatVm.selectedReplyMessage.sender!.name}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: greyText, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundGrey,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Stack(
              children: [
                // Message content
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Text(
                    chatVm.selectedReplyMessage.text!.content.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Cancel button in top-right corner
                Positioned(
                  top: -12,
                  right: -5,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 22,
                    onPressed: chatVm.userCancelReply,
                    icon: const Icon(Icons.cancel_outlined,
                        color: Color.fromARGB(255, 62, 60, 59)),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
