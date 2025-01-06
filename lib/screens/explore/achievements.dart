import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:zineapp2023/components/widgets.dart';

import '../../components/gradient.dart';
import '../../providers/dictionary.dart';
import '../../../theme/color.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  bool isEven(int index) {
    return index % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
      builder: (context, dict, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            title: appbarTitle("Achievements"),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: mainGrad //need to replace with made component
                  ),
            ),
          ),
          body: Timeline.tileBuilder(
            builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.alternating,
              oppositeContentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: isEven(index)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dict.achievementScreen.achievement![index].title!,
                      textAlign:
                          isEven(index) ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      dict.achievementScreen.achievement![index].date!
                          .toUpperCase(),
                      textAlign:
                          isEven(index) ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 12.0),
                child: Text(
                  dict.achievementScreen.achievement![index].description!,
                  textAlign: isEven(index) ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14.0),
                ),
              ),
              connectorBuilder: (context, index, ConnectorType c) =>
                  const SolidLineConnector(
                color: Color(0xffAAAAAA),
              ),
              indicatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: iconTile,
                  radius: 25.0,
                  child: ImageIcon(
                    AssetImage(
                        "assets/images/achievements/${dict.achievementScreen.achievement![index].type}.png"),
                    color: Colors.black,
                  ),
                ),
              ),
              itemCount: dict.achievementScreen.achievement!.length,
            ),
          ),
        );
      },
    );
  }
}
