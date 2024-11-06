import 'package:flutter/material.dart';
import '../../../../models/rooms.dart';
import '../../../../theme/color.dart';
import '../../../../utilities/date_time.dart';

class ChatGroupTile extends StatelessWidget {
  ChatGroupTile(
      {required this.name,
      required this.chatVm,
      required this.userProv,
      required this.groupId,
      required this.roomDetails,
      super.key});

  final String name;
  final dynamic chatVm;
  final dynamic userProv;
  final String groupId;
  Rooms roomDetails;

  @override
  Widget build(BuildContext context) {
    //var roomData= chatVm.getRoomData2(groupId);
    // chatVm.getLastMessages(name);
    // var lastChat = chatVm.lastChatRoom(name);

//    bool unSeen = chatVm.unread(name, userProv.currUser);
//     chatVm.listenChanges(name);

    //Rooms docData=chatVm.docData;
    //print("image by fetching:${docData.image}");

    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            child: roomDetails.unreadMessages != null &&
                    roomDetails.unreadMessages! > 0
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(47, 128, 237, 1),
                    ),
                    height: 20,
                    width: 20,
                    child: Center(
                      child: Text(
                        roomDetails.unreadMessages.toString(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                : Container()),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Set the border radius here
                ),
                color: const Color.fromRGBO(170, 170, 170, 0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(17.0),
                          child:
                              // roomDetails.dpUrl !=null ? Image.network(
                              //   roomDetails.dpUrl.toString(),
                              //   height: 30,
                              //   width: 30,
                              //   fit: BoxFit.cover,
                              //   color: textColor.withOpacity(0.9),
                              // ):

                              (roomDetails.dpUrl == null)
                                  ? Image.asset(
                                      "assets/images/zine_logo.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      color: textColor.withOpacity(0.9),
                                    )
                                  : Image.network(roomDetails.dpUrl!,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      color: textColor.withOpacity(0.9)),
                        ),
                      ),
                    ),
                    roomDetails.lastMessageTimestamp != null ?
                    Text(
                      getLastSeenFormat(roomDetails.lastMessageTimestamp!),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: greyText.withOpacity(0.6)),
                    ):Text(""),
                    const SizedBox(
                      height: 10,
                    ),
                    // Spacer()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              // mp[map[index]]!,
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6)),
            )
          ],
        )
      ],
    );
  }
}
