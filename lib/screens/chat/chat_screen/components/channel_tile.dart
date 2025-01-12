import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import '../../../../models/rooms.dart';
import '../../../../models/user.dart';
import '../../../../utilities/date_time.dart';
import '../chat_room.dart';

class Channel extends StatelessWidget {
  final Rooms roomDetail;

  const Channel({super.key, required this.roomDetail});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
        builder: (context, chatVm, userProv, _) {
      UserModel currUser = userProv.getUserInfo;
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatRoom(
                          // roomName: roomDetail?.name,
                          // roomId: roomDetail.id.toString(),
                          email: currUser.email,
                          roomDetail: roomDetail,
                        )));
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Color.fromRGBO(170, 170, 170, 0.1),
              // : const Color.fromRGBO(47, 128, 237, 0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      File(roomDetail.dpUrl.toString()).existsSync() ?  CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                         child: chatVm.showProfileImage(roomDetail.dpUrl!,radius: 50.0),
                        // foregroundImage:
                        // roomDetail.dpUrl !=null ? CachedNetworkImageProvider(
                        //   roomDetail.dpUrl!,
                        //   errorListener: (p0) {
                        //     // Handle Errors Gracefully and dont dump on the debug console
                        //     if (kDebugMode) {
                        //       print("Error in loading Image : $p0");
                        //     }
                        //   },
                        // ):CachedNetworkImageProvider("assets/images/zine_logo.png"),
                        // backgroundImage:
                        //     const AssetImage("assets/images/zine_logo.png"),
                      ):CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          backgroundImage:AssetImage("assets/images/zine_logo.png")),
                      SizedBox(
                        width: 10,
                      ),
                      roomDetail.name != null
                          ? (Text(
                              roomDetail.name.toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                          : const Text(""),
                      ],
                  ),

                  // -------------------modification for new unseen and lastseen--------------//

                  Row(
                    children: [
                      Row(
                        children: [
                          roomDetail.unreadMessages != null &&
                                  roomDetail.unreadMessages! > 0
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromRGBO(47, 128, 237, 1),
                                  ),
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      roomDetail.unreadMessages.toString(),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      roomDetail?.unreadMessages != null
                          ? roomDetail.unreadMessages! == 0
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // color:
                                    //     const Color.fromRGBO(47, 128, 237, 1),
                                  ),
                                  height: 30,
                                  width: 60,
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                      roomDetail?.lastMessageTimestamp != null
                                          ? getLastSeenFormat(
                                              roomDetail.lastMessageTimestamp!)
                                          : "",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 75, 74, 74),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                          : Container()
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
