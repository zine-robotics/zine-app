import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/chat/chat_description/chat_descp.dart';
import 'package:zineapp2023/screens/chat/chat_screen/components/reply_card.dart';
import 'package:zineapp2023/screens/chat/chat_screen/components/file_selector_tile.dart';
import 'package:zineapp2023/screens/chat/chat_screen/poll_screen.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import '../../../components/gradient.dart';
import '../../../database/database.dart';
import '../../../models/newUser.dart';
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
  final ScrollController _scrollController = ScrollController();

  // Store the last known scroll position
  double? _lastScrollOffset;

  late ChatRoomViewModel chatRoomView;
  late final FocusNode _focusNode;
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _saveRoomNameToPreferences();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        _lastScrollOffset = _scrollController.offset;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatRoomView = Provider.of<ChatRoomViewModel>(context, listen: false);
      var db = Provider.of<AppDb>(context, listen: false);
      if (widget.roomDetail?.id != null) {
        chatRoomView.staticMessagePipeline(
            db, widget.roomDetail!.id.toString());
        chatRoomView.setRoomId(widget.roomDetail!.id.toString(), db);
      }
    });

    _focusNode = FocusNode(
      onKeyEvent: (FocusNode node, KeyEvent evt) {
        bool is_enter = evt.logicalKey == LogicalKeyboardKey.enter;

        bool is_shift = HardwareKeyboard.instance.logicalKeysPressed
                .contains(LogicalKeyboardKey.shiftLeft) ||
            HardwareKeyboard.instance.logicalKeysPressed
                .contains(LogicalKeyboardKey.shiftRight);

        if (!is_shift && is_enter) {
          if (evt is KeyDownEvent) {
            _sendMessage();
          }
          return KeyEventResult.handled;
        } else if (HardwareKeyboard.instance.physicalKeysPressed
                .contains(PhysicalKeyboardKey.shiftLeft) &&
            evt.logicalKey.keyLabel == 'Enter') {
          _messageController.text += "\n";

          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      chatRoomView.sendMessage(text, widget.roomDetail!.name.toString());
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (chatRoomView.messages.isNotEmpty) {
      Future.microtask(() async {
        await chatRoomView.updateSeen(
          widget.email!.toString(),
          widget.roomDetail!.id.toString(),
          DateTime.now(),
          chatRoomView.messages[0].timestamp!,
          0,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("roomName", " ");
        // chatRoomView.loadRooms();
      });
    }
  }

  Future<void> _saveRoomNameToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("roomId", widget.roomDetail!.id.toString());
    // print('Room name saved: ${widget.roomName}');
  }

  // final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatRoomViewModel, DashboardVm, UserProv>(
      builder: (context, chatVm, dashVm, userProv, _) {
        if (_lastScrollOffset != null && _scrollController.hasClients) {
          // Defer the scroll to the next frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients &&
                _lastScrollOffset! <=
                    _scrollController.position.maxScrollExtent) {
              _scrollController.jumpTo(_lastScrollOffset!);
            }
          });
        }
        final roomName = widget.roomDetail!.name.toString();
        final image = widget.roomDetail!.dpUrl.toString();
        // print("\n\ninside chat_room,image:$image\n\n");
        UserModel currUser = userProv.getUserInfo;
        bool isAllowedTyping = true;
        List<RoomMemberModel>? listOfUsers = chatVm.activeMembers;
        //
        logger.d(
            "Building room: $roomName , id : ${widget.roomDetail!.id.toString()}");

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
                        roomName: roomName,
                        image: image,
                        data: listOfUsers ?? []);
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
                    chatV(context, dashVm, chatVm.userReplyText),

                    if (isAllowedTyping)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  chatVm.replyTo != null
                          chatVm.replyTo != null
                              ? ReplyCard(
                                  chatVm: chatVm,
                                )
                              : Container(),
                          (chatVm.isFileLoading)
                              ? (chatVm.isFileReady)
                                  ? FileSelectorTile(chatVm)
                                  : Container(
                                      child: LinearProgressIndicator(),
                                      color: Colors.green,
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
                                      focusNode:
                                          _focusNode, //chatVm.replyfocus,
                                      maxLines: null,
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
                                      icon: const Icon(
                                        Icons.poll,
                                        color: greyText,
                                      ),
                                      onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const PollCreatorScreen(),
                                          ))),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.upload_rounded,
                                      color: greyText,
                                    ),
                                    onPressed: () => chatVm.startFileSelect(),
                                  ),
                                  IconButton(
                                    splashRadius: 30.0,
                                    visualDensity: const VisualDensity(
                                        horizontal: 4.0, vertical: 1.0),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (chatVm.isFileReady) {
                                        chatVm
                                            .sendFile(_messageController.text);
                                      } else {
                                        _sendMessage();
                                        // chatVm.sendMessage(
                                        // _messageController.text, roomName);
                                        // _messageController.text = "";
                                        chatVm.replyTo = null;
                                      }
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
