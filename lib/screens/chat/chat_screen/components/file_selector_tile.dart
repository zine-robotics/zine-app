import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/theme/color.dart';

class FileSelectorTile extends StatelessWidget {
  final ChatRoomViewModel chatVm;
  FileSelectorTile(
    this.chatVm, {
    super.key,
  });
  final List<String> imageExtensions = const [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp'
  ];

  @override
  Widget build(BuildContext context) {
    bool isImage = imageExtensions.contains(chatVm.fileName.split('.').last);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyText),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (isImage)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:FileImage(File(chatVm.filePath)),//Image.file(chatVm.filePath),
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(chatVm.fileName),
              IconButton(
                  onPressed: () {
                    chatVm.cancelUpload();
                    },
                  icon: const Icon(Icons.cancel_outlined))
            ],
          ),
        ],
      ),
    );
  }
}
