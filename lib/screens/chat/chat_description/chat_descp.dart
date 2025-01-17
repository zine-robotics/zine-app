import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/components/profile_picture.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/screens/chat/chat_screen/chat_room.dart';

import '../../../models/newUser.dart';
import '../chat_screen/view_model/chat_room_view_model.dart';

class ChatDescription extends StatelessWidget {
  const ChatDescription({
    required this.roomName,
    required this.data,
    required this.image,
    super.key,
  });

  final String roomName;
  final String image;
  final List<RoomMemberModel>? data;

  @override
  Widget build(BuildContext context) {
    ChatRoomViewModel chatVm =
        Provider.of<ChatRoomViewModel>(context, listen: true);
    print("image in active member is :${image}");
    return Consumer<ChatRoomViewModel>(builder: (context, chatVm, _) {
      return Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: textColor,
            iconSize: 35,
            padding: const EdgeInsets.all(20),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(10.0),
                      child: File(image).existsSync()
                          ? chatVm.showProfileImage(image,
                              height: 100.0, width: 100.0)
                          // Image.file(
                          //   File(image),
                          //   fit: BoxFit.cover, // Ensures the image covers the circle
                          //   width: 70, // Set to 2 * radius
                          //   height: 70, // Set to 2 * radius
                          // )
                          // Image.network(
                          //   image['dpUrl'],
                          //   height: 50,
                          //   width: 50,
                          //   fit: BoxFit.cover,
                          //   color: textColor.withOpacity(0.9),
                          // )
                          : Image.asset(
                              "assets/images/zine_logo.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              // color: textColor.withOpacity(0.9),
                            )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  20.0,
                  0,
                  0,
                ),
                child: Text(
                  roomName,
                  style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
                child: Text(
                  "Total Members: ${chatVm.currentRoomMembers.length} ",
                  style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Future.value(
                    chatVm.currentRoomMembers.values.toList()
                      ..sort((a, b) => b.isActive ? 1 : -1),
                  ),
                  builder:
                      (context, AsyncSnapshot<List<RoomMemberModel>> snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No members found."));
                    }

                    final sortedRoomMembers = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: sortedRoomMembers.length,
                      itemBuilder: (context, index) {
                        final roomMember = sortedRoomMembers[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(5.0),
                                      child: File(roomMember.dpUrl.toString())
                                              .existsSync()
                                          ? chatVm.showProfileImage(
                                              roomMember.dpUrl.toString())
                                          : chatVm.customUserName(
                                              roomMember.name ?? "User"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      roomMember.name ?? "Anonymous",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            15,
                                        fontWeight: FontWeight.bold,
                                        color: textDarkBlue,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      roomMember.email ?? "email@example.com",
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            12.5,
                                        color: textDarkBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (roomMember.isActive) ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: Colors.green,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Online",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10,)
                                ] else ...[
                                  Icon(
                                    Icons.circle_rounded,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Offline",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 10,)
                                ],
                                // const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    });
  }
}

class FallbackIconImage extends StatelessWidget {
  const FallbackIconImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/zine_logo.png",
      fit: BoxFit.cover,
      color: textColor.withOpacity(0.9),
    );
  }
}
