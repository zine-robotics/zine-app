import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/theme/color.dart';

import 'dp_change_repo.dart';

class DpChangeScreen extends StatelessWidget {
  final String title;
  DpChangeScreen({this.title = 'Profile Picture', super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProv>(builder: (context, userProv, child) {
      String image = userProv.getUserInfo.dp;

      Widget dp = File(image.toString()).existsSync()
          ? Image.file(File(image.toString()))
          : Image.asset("assets/images/dp/$image.png");
      return Scaffold(
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            leading: IconButton(
              color: greyText,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
            centerTitle: true,
            title: const Text(
              "Profile",
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            actions: [
              IconButton(
                color: greyText,
                onPressed: () {
                  if (kDebugMode) {
                    print("Uploading");
                  }
                  DPUpdateRepo.upload(userProv.updateDpUrl, userProv.getUserInfo.uid!,
                      userProv.getUserInfo.id.toString());
                },
                icon: const FaIcon(FontAwesomeIcons.pencil),
              ),
              const SizedBox(
                width: 20.0,
              )
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
          ),
          body: Center(
              child: Expanded(
                  child: Container(
                      width: double.infinity,
                      child: Hero(tag: "profilePic", child: dp)))));
    });
  }
}
