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
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              "Reply To ${chatVm.selectedReplyMessage.sentFrom!.name}",
              textAlign: TextAlign.left,
              style: const TextStyle(color: greyText, fontSize: 11),
            ),
          ),
        ),
        Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: backgroundGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    // heightFactor: 1,
                    // widthFactor: 1,
                    child: Container(
                      constraints: BoxConstraints.tight(const Size.square(20)),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: chatVm.userCancelReply,
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38)),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    child: Text(
                      chatVm.selectedReplyMessage.text.toString(),

                      // softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
