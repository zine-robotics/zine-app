import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/components/profile_picture.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/theme/color.dart';

class ChatDescription extends StatelessWidget {
  const ChatDescription({
    required this.roomName,
    required this.data,
    required this.image,
    super.key,
  });

  final String roomName;
  final String image;
  final List<ActiveMember> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: textColor,
          iconSize: 35,
          padding: const EdgeInsets.all(20),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    // padding: EdgeInsets.all(5),
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: image,
                      placeholder: (_, __) => const FallbackIconImage(),
                      errorWidget: (_, __, ___) => const FallbackIconImage(),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                20.0,
                0,
                0,
              ),
              child: Text(
                roomName,
                style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 10),
              child: Text(
                "${data.length} Active Members",
                style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ProfilePicture(
                                        dp: data[index].dpUrl,
                                        name: data[index].name,
                                        size: 22.5)),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name.toString(),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                              .textScaleFactor *
                                          15,
                                      fontWeight: FontWeight.bold,
                                      color: textDarkBlue),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  data[index].email.toString(),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                              .textScaleFactor *
                                          12.5,
                                      color: textDarkBlue),
                                )
                              ],
                            ),
                            const Spacer(),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.fromLTRB(8.0, 16, 16, 0),
                            //   child: Text(
                            //     "",
                            //     style: TextStyle(
                            //         color: textColor,
                            //         fontSize:
                            //             MediaQuery.of(context).textScaleFactor *
                            //                 13),
                            //   ),
                            // )
                          ],
                        ),
                      ));
                },
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class FallbackIconImage extends StatelessWidget {
  const FallbackIconImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/zine_logo.png",
      fit: BoxFit.cover,
      color: textColor.withOpacity(0.9),
    );
  }
}
