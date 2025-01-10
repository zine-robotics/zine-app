import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:zineapp2023/components/profile_picture.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_screen/file_tile.dart';
import 'package:zineapp2023/screens/chat/chat_screen/poll_tile.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import '../../../models/message.dart';
import '../../../theme/color.dart';
import '../../../utilities/date_time.dart';

Widget chatV(BuildContext context, dashVm, dynamic reply) {
  ChatRoomViewModel chatRoomViewModel =
      Provider.of<ChatRoomViewModel>(context, listen: true);
  List<MessageModel> chats = chatRoomViewModel.messages;
  UserProv userVm = Provider.of<UserProv>(context, listen: true);

  // If there are no messages
  print("messages:...................... $chats");
  print(chats);
  if (chats.isEmpty) {
    return const Expanded(
      child: Center(
        child: Column(
          children: [
            Spacer(),
            Icon(
              Icons.message,
              size: 50,
              color: textDarkBlue,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No Messages',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  } else {
    return Flexible(
      // Flexible prevents overflow error when keyboard is opened

      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          reverse: true,
          // physics: NeverScrollableScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          shrinkWrap: true,
          key: UniqueKey(),
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            // print("chats[currIndx].sentFrom:${chats[index].sentFrom ==null} and userVm.getUserInfo.name${userVm.getUserInfo.name}");
            var currIndx = chats.length - index - 1;
            bool isUser =
                (userVm.getUserInfo.id == chats[currIndx].sentFrom!.id);
            var showDate = index == chats.length - 1 ||
                (chats.length - index >= 2 &&
                    validShowDate(chats[currIndx].timestamp!) !=
                        validShowDate(
                            chats[chats.length - index - 2].timestamp!));

            bool group = index > 0 &&
                chats[currIndx].sentFrom!.id ==
                    chats[chats.length - index].sentFrom?.id &&
                getChatDate(chats[currIndx].timestamp!) ==
                    getChatDate(chats[chats.length - index].timestamp!);

            dynamic repliedMessage;
            // print("reply to:${chats[currIndx].replyTo}");
            if (chats[currIndx].replyTo != null) {
              repliedMessage = chatRoomViewModel.userGetMessageById(
                  chats, chats[currIndx].replyTo.toString());
              // print("checking reply content:${chats[currIndx].content}");
            }

            if (chats[currIndx].type == MessageType.text) {
              return chats[currIndx].text!.isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          repliedMessage != null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Padding(
                                    padding: userVm.getUserInfo.id !=
                                            chats[currIndx].sentFrom!.id
                                        //currUser.name != chats[currIndx].from
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 35.0)
                                        : const EdgeInsets.all(0),
                                    child: Text(
                                      "${isUser ? "You" : chats[currIndx].sentFrom?.id} replied to ${chats[currIndx].replyTo?.sentFrom?.id}",
                                      textAlign: isUser
                                          ? TextAlign.right
                                          : TextAlign.left,
                                      style: const TextStyle(
                                          color: greyText, fontSize: 11),
                                    ),
                                  ),
                                )
                              : Container(),
                          repliedMessage != null
                              ? Row(
                                  // direction: Axis.horizontal,
                                  mainAxisAlignment: isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: isUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    isUser
                                        ? Container()
                                        : const CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              // child: Image.asset(
                                              //     "assets/images/zine_logo.png"),
                                            ),
                                          ),
                                    isUser
                                        ? IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: backgroundGrey,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      repliedMessage != null
                                                          ? (repliedMessage
                                                                          .content
                                                                          .toString())
                                                                      .length >
                                                                  20
                                                              ? '${repliedMessage.content.toString().substring(0, 20)}...'
                                                              : repliedMessage
                                                                  .content
                                                                  .toString()
                                                          : " ",
                                                      // softWrap: true,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Container(
                                                    color:
                                                        const Color(0xff68a5ca),
                                                    width: 4,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12.0),
                                                      child: Text(
                                                        "",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    isUser
                                        ? IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Container(
                                                    color:
                                                        const Color(0xff0C72B0),
                                                    width: 4,
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12.0),
                                                      child: Text(
                                                        "       ",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : IntrinsicHeight(
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: backgroundGrey,
                                                      borderRadius: userVm
                                                                  .getUserInfo
                                                                  .id !=
                                                              chats[currIndx]
                                                                  .sentFrom
                                                                  ?.id
                                                          ? const BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(
                                                                      15.0),
                                                              topLeft: Radius.circular(
                                                                  5.0),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      5.0),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      15.0))
                                                          : const BorderRadius.only(
                                                              topRight:
                                                                  Radius.circular(5.0),
                                                              topLeft: Radius.circular(15.0),
                                                              bottomLeft: Radius.circular(15.0),
                                                              bottomRight: Radius.circular(5.0))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Text(
                                                      repliedMessage.content
                                                                  .toString()
                                                                  .length >
                                                              20
                                                          ? "${repliedMessage.content.toString().substring(0, 20)} . . ."
                                                          : repliedMessage
                                                              .content
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                )
                              : Container(),
                          if (showDate)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat.yMMMMd()
                                    .format((chats[currIndx].timestamp!))
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: greyText),
                              ),
                            ),
                          Container(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: SwipeTo(
                              onRightSwipe: (details) {
                                // print(details);
                                chatRoomViewModel
                                    .userReplyText(chats[currIndx]);
                                chatRoomViewModel.replyfocus.requestFocus();
                              },
                              // onLeftSwipe: (details) {
                              //   // print(details);
                              //   chatRoomViewModel
                              //       .userReplyText(chats[currIndx]);
                              //   chatRoomViewModel.userReplyfocus
                              //       .requestFocus();
                              // },
                              child: ListTile(
                                horizontalTitleGap: 6,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: isUser || group
                                    ? CircleAvatar(
                                        backgroundColor: const Color.fromARGB(
                                            15, 255, 255, 255),
                                        radius: 25,
                                        child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container()),
                                      )
                                    : File(chats[currIndx]
                                                .sentFrom!
                                                .dp
                                                .toString())
                                            .existsSync()
                                        ? chatRoomViewModel.showProfileImage(
                                            chats[currIndx]
                                                .sentFrom!
                                                .dp
                                                .toString(),
                                            radius: 50.0)
                                        : chatRoomViewModel.customUserName(
                                            chats[currIndx]
                                                .sentFrom!
                                                .name
                                                .toString()), //
                                // buildProfilePicture(chatRoomViewModel,
                                //         chats[currIndx].sentFrom!.dp,
                                //         chats[currIndx].sentFrom!.name),

                                // * Because Priyansh Said So :) *

                                // trailing: currUser.name !=
                                //         chats[currIndx].from
                                //     ? null
                                //     : group
                                //         ? const CircleAvatar(
                                //             backgroundColor: Colors.transparent,
                                //           )
                                //         : CircleAvatar(
                                //             backgroundColor:
                                //                 const Color(0x0f2F80ED),
                                //             child: Padding(
                                //               padding: const EdgeInsets.all(3.0),
                                //               child: Image.asset(
                                //                   "assets/images/zine_logo.png"),
                                //             ),
                                //           ),

                                subtitle: group
                                    ? null
                                    : Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Align(
                                          alignment: userVm.getUserInfo.id !=
                                                  chats[chats.length -
                                                          index -
                                                          1]
                                                      .sentFrom
                                                      ?.id
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                          child: group
                                              ? const Text("")
                                              : Text(
                                                  "${chats[currIndx].sentFrom!.name}     ${getChatTime(chats[currIndx].timestamp!)}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.0,
                                                    color: Color.fromARGB(
                                                        255, 92, 20, 20),
                                                  ),
                                                ),
                                        ),
                                      ),
                                title: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  alignment: isUser
                                      ? WrapAlignment.end
                                      : WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  children: [
                                    // Text("Something"),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: userVm.getUserInfo.id ==
                                                chats[chats.length - index - 1]
                                                    .sentFrom
                                                    ?.id
                                            ? const Color(0xff68a5ca)
                                            : const Color(0xff0C72B0),
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(15.0),
                                            topRight:
                                                const Radius.circular(15.0),
                                            bottomRight: userVm
                                                        .getUserInfo.id ==
                                                    chats[chats.length -
                                                            index -
                                                            1]
                                                        .sentFrom
                                                        ?.id
                                                ? const Radius.circular(0.0)
                                                : const Radius.circular(15.0),
                                            bottomLeft: userVm.getUserInfo.id ==
                                                    chats[chats.length -
                                                            index -
                                                            1]
                                                        .sentFrom
                                                        ?.id
                                                ? const Radius.circular(15.0)
                                                : const Radius.circular(0.0)),
                                        // border: Border.all(color: greyText, width: 2.0),
                                      ),
                                      // margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SelectableLinkify(
                                          text: chats[currIndx].text.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                          onOpen: (link) =>
                                              dashVm.launchUrl(link.url),
                                          linkStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.0,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
            } else if (chats[currIndx].type == MessageType.poll &&
                chats[currIndx].poll != null) {
              return PollTile(
                message: chats[currIndx],
                isUser: isUser,
                onVote: (optionId) => chatRoomViewModel.sendPollResponse(
                    chats[currIndx].id!, optionId),
              );
            } else if (chats[currIndx].type == MessageType.file &&
                chats[currIndx].file != null) {
              return FileTile(
                message: chats[currIndx],
                isUser: isUser,
              );
            }
          },
        ),
      ),
    );
  }

  // print(chats);
  // print(MessageModel.store());
}

Widget buildProfilePicture(ChatRoomViewModel chatVm, String dp, String name,
    {double size = 20}) {
  double width = size * 2.0;
  return Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
          minWidth: width, minHeight: width, maxHeight: width, maxWidth: width),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: File(dp.toString()).existsSync()
          ? chatVm.showProfileImage(dp)
          : chatVm.customUserName(name)
      // CachedNetworkImage(
      //   imageUrl: dp,
      //   fit: BoxFit.cover,
      //   errorWidget: (_, __, ___) => Center(
      //       child: Text(
      //     name.substring(0, 1).toUpperCase(),
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: size,
      //     ),
      //   )),
      // ),
      );
}
