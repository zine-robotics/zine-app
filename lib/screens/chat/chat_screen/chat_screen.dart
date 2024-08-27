import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/temp_rooms.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import '../../../providers/user_info.dart';
import '../../../theme/color.dart';
import 'chat_groups/chats_group.dart';
import 'channel_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var chatRoomView=Provider.of<ChatRoomViewModel>(context, listen: false);
      chatRoomView.loadRooms();
    });
  }
  Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: greyText,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatRoomViewModel, UserProv>(
      builder: (context, chatVm, userProv, _) {
        // var currUser = userProv.currUser;
        List<TempRooms>? roomDetails=chatVm.user_rooms;
        List<TempRooms>? projectDetails=chatVm.userProjects;
        // var roomDetails = currUser.roomDetails;
        // var projects = roomDetails['project'].values.toList();


        return Container(
          color: backgroundGrey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --------------------Channels-------------------------------
                  headingText("Channels"),
                   Channel(
                    name: "Announcements",
                    roomId: "452",

                  ),

                  //--------------------Groups/Room----------------------------------
                  roomDetails !=null
                      ? headingText("Groups")
                      : Container(),
                  roomDetails !=null
                      ? ChatGroups(roomDetails: roomDetails )
                      : Container(),

                  const SizedBox(
                    height: 20,
                  ),

                  //--------------------Projects-----------------------------------R
                  projectDetails !=null
                      ? headingText("Project")
                      : Container(),
                  if (projectDetails !=null)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5, // You can adjust the height as needed
                      child: chatVm.isRoomLoading? Center(child: CircularProgressIndicator()) :ListView.builder(
                        itemCount: projectDetails?.length,
                        itemBuilder: (BuildContext context, int index) {

                          TempRooms item = projectDetails[index];
                          return Channel(
                            name: item.name ?? " ",
                            roomId:item.id.toString(),
                          );
                        },
                      ),
                    )
                  else
                    Center(child: Text('No rooms available')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}