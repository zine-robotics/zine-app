import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_description/chat_descp.dart';
import 'package:zineapp2023/screens/chat/chat_screen/components/reply_card.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import '../../../components/gradient.dart';
import '../../../models/rooms.dart';
import 'chat_view.dart';

class ChatRoom extends StatefulWidget {
  // final dynamic roomName;
  String? email;
  // final String? roomId;
  Rooms? roomDetail;

  ChatRoom({Key? key, this.roomDetail, this.email}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late ChatRoomViewModel chatRoomView;
  @override
  void initState() {
    super.initState();
    _saveRoomNameToPreferences();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatRoomView = Provider.of<ChatRoomViewModel>(context, listen: false);
      widget.roomDetail?.id != null
          ? chatRoomView.fetchMessages(widget.roomDetail!.id.toString())
          : "";
      widget.roomDetail?.id != null
          ? chatRoomView.setRoomId(widget.roomDetail!.id.toString())
          : "";
      chatRoomView.getTotalActiveMember(widget.roomDetail!.id.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (chatRoomView.messages.isNotEmpty) {
      Future.microtask(() async {
        await chatRoomView.updateSeen(
          widget.email!.toString(),
          widget.roomDetail!.id.toString(),
          DateTime.now().millisecondsSinceEpoch,
          chatRoomView.messages[0].timestamp!,
          0,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("roomId", " ");
        chatRoomView.loadRooms();
      });
    }
  }

  Future<void> _saveRoomNameToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("roomId", widget.roomDetail!.id.toString());
    // print('Room name saved: ${widget.roomName}');
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatRoomViewModel, DashboardVm, UserProv>(
      builder: (context, chatVm, dashVm, userProv, _) {
        final roomName = widget.roomDetail!.name.toString();
        final String roomImage = widget.roomDetail!.dpUrl;
        UserModel currUser = userProv.getUserInfo;
        bool isAllowedTyping = true;
        List<ActiveMember> listOfUsers = chatVm.activeMembers;
        //

        if (currUser.type == 'user' && roomName == 'Announcements') {
          isAllowedTyping = false;
        }


        chatVm.addRouteListener(
            context, roomName, userProv.getUserInfo.email.toString(), userProv);

        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    // return Text("chatDesctiption remove");
                    return ChatDescription(
                        roomName: roomName, image: roomImage, data: listOfUsers);
                  }));
                },
                child: Text(
                  roomName,
                  // "hello again",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: mainGrad //need to replace with made component
                    ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0),
                ),
                // border: Border.all(color: greyText, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // chatV(data, currUser, dashVm, chatVm.replyText,
                    //     chatVm.updateMessage, context),
                    chatV(context, chatVm.messageStream, dashVm,
                        chatVm.userReplyText),

                    if (isAllowedTyping)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatVm.replyfocus.hasFocus && chatVm.replyTo != null
                              ? ReplyCard(
                                  chatVm: chatVm,
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                border: Border.all(color: greyText, width: 2.0),
                              ),
                              child: Row(
                                children: <Widget>[
                                  // IconButton(
                                  //     onPressed: () =>
                                  //         {chatVm.pickImage(ImageSource.gallery)},
                                  //     icon: Icon(Icons.image)),
                                  const SizedBox(
                                    width: 10.0,
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      focusNode: chatVm.replyfocus,
                                      maxLines: 3,
                                      minLines: 1,
                                      controller: _messageController,
                                      onChanged: (value) =>
                                          chatVm.setText(value),
                                      decoration: const InputDecoration(
                                          hintText: "Type Your Message",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                    splashRadius: 30.0,
                                    visualDensity: const VisualDensity(
                                        horizontal: 4.0, vertical: 1.0),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      chatVm.sendMessage(
                                          _messageController.text, roomName);
                                      _messageController.text = "";
                                      chatVm.replyTo = null;
                                    },
                                    iconSize: 20.0,
                                    icon: const ImageIcon(
                                      AssetImage("assets/images/send.png"),
                                      color: greyText,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Container()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
