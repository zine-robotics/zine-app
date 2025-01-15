import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img; // Add `image` package in pubspec.yaml
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
    bool isImage =
        imageExtensions.contains(chatVm.fileName.split('.').last.toLowerCase());
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyText),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (isImage)
            _buildImagePreview(chatVm.filePath, context)
          else
            _buildFilePreview(chatVm.fileName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  chatVm.fileName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  chatVm.cancelUpload();
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(String imagePath, BuildContext context) {
    final maxHeight = 150.0; // Fixed max height
    final maxWidth = 150.0; // Fixed max width

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: maxWidth,
        height: maxHeight,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: maxWidth,
            height: maxHeight,
            color: Colors.grey[200],
            child: const Icon(Icons.error, color: Colors.red),
          );
        },
      ),
    );
  }

  Widget _buildFilePreview(String fileName) {
    return Row(
      children: [
        const Icon(Icons.insert_drive_file, size: 50, color: Colors.grey),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            fileName,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
