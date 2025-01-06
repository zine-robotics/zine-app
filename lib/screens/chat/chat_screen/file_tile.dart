import 'package:flutter/material.dart';
import 'package:zineapp2023/models/message.dart';

class FileTile extends StatefulWidget {
  final MessageModel message;
  final bool isUser;
  const FileTile({super.key, required this.message, required this.isUser});
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
    return Column(
        crossAxisAlignment:
            widget.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          InkWell(
              child: Container(
            child: Column(
              children: [
                Container(
                  child: Text(widget.message.file!.name),
                )
              ],
            ),
          ))
        ]);
  }
}
