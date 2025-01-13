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
    bool isImage = imageExtensions.contains(chatVm.fileName.split('.').last);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyText),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (isImage) _buildImagePreview(chatVm.filePath, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(chatVm.fileName),
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
    Future<Size> _getImageSize(String path) async {
      final imageFile = File(path);
      final imageBytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage != null) {
        return Size(
            decodedImage.width.toDouble(), decodedImage.height.toDouble());
      }
      return const Size(1, 1); // Default aspect ratio if image can't be decoded
    }

    return FutureBuilder<Size>(
      future: _getImageSize(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(
            child: Text("Unable to load image"),
          );
        }

        final imageSize = snapshot.data!;
        final aspectRatio = imageSize.width / imageSize.height;
        final maxHeight = MediaQuery.of(context).size.height * 0.5;

        return LayoutBuilder(
          builder: (context, constraints) {
            double adjustedHeight = maxHeight;
            double adjustedWidth = adjustedHeight * aspectRatio;

            // Constrain width and height to the available layout size
            if (adjustedWidth > constraints.maxWidth) {
              adjustedWidth = constraints.maxWidth;
              adjustedHeight = adjustedWidth / aspectRatio;
            }

            return SizedBox(
              width: adjustedWidth,
              height: adjustedHeight,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: FileImage(File(imagePath)),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
