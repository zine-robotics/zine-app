import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

class FileTile extends StatefulWidget {
  final ChatRoomViewModel chatRoomViewModel;
  final bool group;
  final MessageModel message;
  final bool isUser;
  const FileTile(
      {super.key,
      required this.message,
      required this.isUser,
      required this.group,
      required this.chatRoomViewModel});
  final List<String> imageExtensions = const [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp'
  ];
  @override
  State<FileTile> createState() => _FileTileState();
}

class _FileTileState extends State<FileTile> {
  @override
  Widget build(BuildContext context) {
    bool isImage = widget.imageExtensions
        .contains((widget.message.file!.name).split('.').last.toLowerCase());
    bool startImage = widget.message.file!.uri.toString().startsWith('http');

    return ListTile(
        contentPadding: widget.isUser
            ? const EdgeInsets.only(top: 10, left: 30)
            : const EdgeInsets.only(top: 10, right: 30),
        titleAlignment: ListTileTitleAlignment.center,
        leading: widget.isUser || widget.group
            ? CircleAvatar(
                backgroundColor: const Color.fromARGB(15, 255, 255, 255),
                radius: 25,
                child: Padding(
                    padding: const EdgeInsets.all(20.0), child: Container()),
              )
            : File(widget.message.sender!.dp.toString()).existsSync()
                ? widget.chatRoomViewModel.showProfileImage(
                    widget.message.sender!.dp.toString(),
                    radius: 50.0)
                : widget.chatRoomViewModel
                    .customUserName(widget.message.sender!.name.toString()),
        title: InkWell(
            onTap: () {},
            child: ClipRRect(
                borderRadius: widget.isUser
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                child: File(widget.message.file!.uri.toString()).existsSync()
                    ? Image.file(File(widget.message.file!.uri.toString()))
                    : startImage
                        ? Image.network(widget.message.file!.uri.toString())
                        : SizedBox.shrink()))
        //Icon(Icons.photo)//Image.network(widget.message.file!.uri.toString()),
        );
  }
}
