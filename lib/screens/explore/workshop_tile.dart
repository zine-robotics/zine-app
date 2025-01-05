import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../models/events.dart';
import '../../theme/color.dart';

class WorkshopTile extends StatelessWidget {
  List<Events> events;
  WorkshopTile({required this.events, super.key});

  @override
  Widget build(BuildContext context) {
    List<Events> event = events;
    // print(image[i]);

    //print("image error handling:${events[0].image}");
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        Column(
          children: [
            Text(
              events[0].recruitment!.title!,
              style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
            Text("Stage ${events[0].recruitment!.stage}",
                style: const TextStyle(color: greyText, fontSize: 16.0)),
          ],
        ),
        // for (int j = 0; j < events.length; j++)
        //   events[j].isHeading == "true"
        //       ? Column(
        //           children: [
        //             Text(
        //               "${events[j].name.toString()}",
        //               style: const TextStyle(
        //                   color: textColor,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 25.0),
        //             ),
        //             Text("Stage ${events[j].stage.toString()}",
        //                 style:
        //                     const TextStyle(color: greyText, fontSize: 16.0)),
        //           ],
        //         )
        //       : Container(),

        /* Text(
          "Stage ${events[i].stage.toString()}",
          style: const TextStyle(color: greyText, fontSize: 16.0),
        ),*/

        Timeline.tileBuilder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          builder: TimelineTileBuilder.connected(
            contentsAlign: ContentsAlign.alternating,
            oppositeContentsBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: index % 2 == 0
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event[index].name!,
                    textAlign:
                        index % 2 == 0 ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    event[index].description!,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    textAlign:
                        index % 2 == 0 ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                        color: greyText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
            contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 55.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: index % 2 == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(
                          (
                              event[index].startDateTime!)),
                      // .format(event[index].timeDate!.toDate()),
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0),
                    ),
                    Text(
                      DateFormat.jm().format(
                          (
                              event[index].startDateTime!)),
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xff6d93aa),
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0),
                    ),
                    Text(
                      event[index].venue!,
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xff6d93aa),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                  ],
                )),
            connectorBuilder: (context, index, ConnectorType c) =>
                const SolidLineConnector(
              color: Color(0xffAAAAAA),
            ),
            indicatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: iconTile,
                  radius: 30.0,
                  child:
                      /*  AssetImage(
                      "assets/images/timeline/${i == 1 ? events[index].name!.toLowerCase() : image[i].toString().toLowerCase()}.png"),
              */

                      // event[index].image!.isNotEmpty
                      //     ? Image.network(
                      //         event[index].image.toString(),
                      //         color: Colors.black,
                      //         width: 35,
                      //       )
                      //     :
                      Image.asset(
                    'assets/images/zine_logo.png',
                    color: Colors.black,
                    width: 45,
                  )),
            ),
            itemCount: event.length,
          ),
        )
      ],
    );
  }
}
