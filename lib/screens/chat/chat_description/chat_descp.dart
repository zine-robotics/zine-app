import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/screens/chat/chat_screen/chat_view.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/screens/chat/chat_screen/chat_room.dart';

import '../chat_screen/view_model/chat_room_view_model.dart';

class ChatDescription extends StatelessWidget {
  ChatDescription({
    required this.roomName,
    required this.data,
    required this.image,
    super.key,
  });

  final String roomName;
  final dynamic image;
  List<ActiveMember> data;


  @override
  Widget build(BuildContext context) {
    print(data);
    print("image in active member is :${image}");
    return Consumer<ChatRoomViewModel>(
        builder: (context,chatVm, _)
    {
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
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child:  File(image).existsSync() ?chatVm.showProfileImage(image,height: 100.0,width: 100.0)
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
                  "${data.length} Active Members",
                  style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
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
                                      child:File(data[index].dpUrl.toString()).existsSync() ? chatVm.showProfileImage(data[index].dpUrl.toString()):chatVm.customUserName(data[index].name.toString())

                                    // buildProfilePicture(
                                    //     data[index].dpUrl, data[index].name,
                                    //     size: 22.5)
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: MediaQuery
                                            .of(context)
                                            .textScaleFactor *
                                            15,
                                        fontWeight: FontWeight.bold,
                                        color: textDarkBlue),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    data[index].email.toString(),
                                    style: TextStyle(
                                        fontSize: MediaQuery
                                            .of(context)
                                            .textScaleFactor *
                                            12.5,
                                        color: textDarkBlue),
                                  )
                                ],
                              ),
                              const Spacer(),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(8.0, 16, 16, 0),
                              //   child: Text(
                              //     "",
                              //     style: TextStyle(
                              //         color: textColor,
                              //         fontSize:
                              //             MediaQuery.of(context).textScaleFactor *
                              //                 13),
                              //   ),
                              // )
                            ],
                          ),
                        ));
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
    }
    );
  }
}
