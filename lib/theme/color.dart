import 'package:flutter/material.dart';

const textColor = Color(0xff0c72b0);
const textDarkBlue = Color(0xff003D63);
const greyText = Color(0xff8D989F);
const blurBlue = Color.fromRGBO(12, 114, 176, 0.643);
const iconTile = Color(0xccD9D9D9);

const backgroundGrey = Color(0xffefefef);

const List<Map<String, Color>> profilePictureColours = [
  {"background": Color(0xff001f54), "text": Color(0xffffffff)}, // Navy Blue
  {"background": Color(0xff333333), "text": Color(0xffffffff)}, // Charcoal Gray
  {"background": Color(0xff708090), "text": Color(0xffffffff)}, // Slate Gray
  {"background": Color(0xfffffff0), "text": Color(0xff000000)}, // Ivory
  {"background": Color(0xffadd8e6), "text": Color(0xff000000)}, // Light Blue
  {"background": Color(0xff98ff98), "text": Color(0xff000000)}, // Mint Green
  {"background": Color(0xffe6e6fa), "text": Color(0xff000000)}, // Lavender
  {"background": Color(0xffffe5b4), "text": Color(0xff000000)}, // Peach
  {"background": Color(0xff800020), "text": Color(0xffffffff)}, // Burgundy
  {"background": Color(0xff228b22), "text": Color(0xffffffff)}, // Forest Green
  {"background": Color(0xff4169e1), "text": Color(0xffffffff)}, // Royal Blue
  {"background": Color(0xffdaa520), "text": Color(0xff000000)}, // Goldenrod
  {"background": Color(0xff008080), "text": Color(0xffffffff)}, // Teal
  {"background": Color(0xffdc143c), "text": Color(0xffffffff)}, // Crimson
  {"background": Color(0xff4b0082), "text": Color(0xffffffff)}, // Indigo
  {"background": Color(0xffff4500), "text": Color(0xffffffff)}, // Sunset Orange
];

Map<String, Color> getDpColours(String name) {
  final int hash = name.hashCode;
  final int index = hash.abs() % profilePictureColours.length;
  return profilePictureColours[index];
}
