import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';

class ProfilePicture extends StatelessWidget {
  final String dp, name;
  final double size;

  const ProfilePicture(
      {super.key, required this.dp, required this.name, this.size = 20});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colours = getDpColours(name);
    Color backgroundColour = colours['background']!;
    Color textColour = colours['text']!;

    double width = size * 2.0;
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(
          minWidth: width, minHeight: width, maxHeight: width, maxWidth: width),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: backgroundColour),
      child: CachedNetworkImage(
        imageUrl: dp,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => Center(
            child: Text(
          name.substring(0, 1).toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size, color: textColour),
        )),
      ),
    );
  }
}
