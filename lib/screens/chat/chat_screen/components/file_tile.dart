import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:open_file/open_file.dart';
String DOWNLOAD_PATH = '/storage/emulated/0/Download';

const Color userColor = Color.fromARGB(255, 104, 181, 228);
const Color userSelectedTextColor = Color.fromARGB(255, 255, 255, 255);
const Color otherColor = Color(0xff0c72b0);
const Color otherSelectedTextColor = Color(0xffE8F2FC);

class FileTile extends StatefulWidget {
  final ChatRoomViewModel chatRoomViewModel;
  final bool group;
  final MessageModel message;
  final bool isUser;

  const FileTile({
    super.key,
    required this.message,
    required this.isUser,
    required this.group,
    required this.chatRoomViewModel,
  });

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
  bool isImage() {
    return widget.imageExtensions
        .contains((widget.message.file!.name).split('.').last.toLowerCase());
  }

  bool _isDownloading = false;

  Future<void> _downloadFile(String url, String fileName) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      // final downloadsPath = Directory(DOWNLOAD_PATH);
      final downloadsPath= await getExternalStorageDirectory();
      if (downloadsPath == null) {
        throw Exception('External storage directory not available.');
      }
      final filePath = '${downloadsPath.path}/$fileName';
      final response = await http.get(Uri.parse(url));
      print("downloaded path is:${filePath}");
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(174, 27, 31, 34),
            content: const Text(
              'File downloaded', // Example text
              textAlign: TextAlign.center, // Center-align the text
            ),
            behavior: SnackBarBehavior.floating,
            // Makes the SnackBar float
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Adds rounded corners
            ),
            margin: const EdgeInsets.only(
              bottom: 70, // Adjust height from the bottom
              left: 50, // Add horizontal spacing
              right: 50, // Add horizontal spacing
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Internal padding
            duration:
                const Duration(seconds: 1), // Sets the duration to 3 seconds
          ),
        );
        final result = await OpenFile.open(filePath);

        // Check the result of the file open operation
        if (result.type != ResultType.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to open the file.')),
          );
        }
      } else {
        throw Exception('Failed to download file.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  void _showImageDialog(String imagePath, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black, // Black background
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Download Button
                      IconButton(
                        icon: const Icon(Icons.download, color: Colors.white),
                        onPressed: () {
                          _downloadFile(imageUrl, imagePath.split('/').last);
                        },
                      ),
                      // Close Button
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool startImage = widget.message.file!.uri.toString().startsWith('http');

    return ListTile(
      contentPadding: widget.isUser
          ? const EdgeInsets.only(top: 10, left: 10)
          : const EdgeInsets.only(top: 10, right: 10),
      titleAlignment: ListTileTitleAlignment.center,
      leading: widget.isUser || widget.group
          ? CircleAvatar(
              backgroundColor: const Color.fromARGB(15, 255, 255, 255),
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(),
              ),
            )
          : File(widget.message.sender!.dp.toString()).existsSync()
              ? widget.chatRoomViewModel.showProfileImage(
                  widget.message.sender!.dp.toString(),
                  radius: 50.0,
                )
              : widget.chatRoomViewModel.customUserName(
                  widget.message.sender!.name.toString(),
                ),
      title: InkWell(
        onTap: () {
          if (isImage()) {
            // Show full-screen image
            if (File(widget.message.file!.filePath).existsSync()) {
              _showImageDialog(widget.message.file!.filePath,
                  widget.message.file!.uri.toString());
            } else if (startImage) {
              _showImageDialog(widget.message.file!.filePath,
                  widget.message.file!.uri.toString());
            }
          }
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 250),
          child: Container(
            decoration: BoxDecoration(
            border: Border.all(
            color: widget.isUser? userColor:otherColor,
            width: 5.0,
            ),
              borderRadius: widget.isUser
                  ? const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
                  : const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: widget.isUser
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
              child: Builder(
                builder: (context) {
                  if (isImage()) {
                    if (File(widget.message.file!.filePath).existsSync()) {
                      return Image.file(
                        File(widget.message.file!.filePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      );
                    } else if (startImage) {
                      return CachedNetworkImage(
                        imageUrl: widget.message.file!.uri.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    }
                  }

                  // Render non-image file with file name
                  return Container(
                    padding: const EdgeInsets.all(8),
                    color: widget.isUser ? userColor : otherColor,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.insert_drive_file,
                          size: 40,
                          color: Color.fromARGB(255, 219, 248, 255),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.message.file!.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.download, color: Colors.white),
                          onPressed: () {
                            if (!_isDownloading) {
                              _downloadFile(
                                widget.message.file!.uri.toString(),
                                widget.message.file!.name,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
