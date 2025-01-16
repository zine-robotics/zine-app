import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:intl/intl.dart';

import '../../../utilities/date_time.dart';

class EventTile extends StatefulWidget {
  const EventTile({
    super.key,
    required this.index,
    required this.event,
    required this.evm,
  });
  final PublicEventsVM evm;
  final int index;
  final Events event;
  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  @override
  Widget build(BuildContext context) {
    DateTime startTime = widget.event.startDateTime!;
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);
    double compressedHeight = availableHeight / 7;
    double expandedHeight = availableHeight / 3.0;

    bool isEventPast = widget.event.startDateTime != null
        ? isPastEvent(widget.event.startDateTime!)
        : true;
    bool expanded = !(widget.evm.expandedEvent == widget.event);

    const duration = Duration(milliseconds: 250);

    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: expanded ? compressedHeight : expandedHeight,
      duration: duration,
      width: double.infinity,
      child: Row(
        children: [
          // Date Section
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  startTime.day.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textDarkBlue,
                  ),
                ),
                Text(
                  DateFormat('MMM').format(startTime),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textDarkBlue,
                  ),
                ),
              ],
            ),
          ),
          // Connector Section
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SolidLineConnector()),
                isEventPast ? Indicator.dot() : Indicator.outlined(),
                const Expanded(child: SolidLineConnector()),
              ],
            ),
          ),
          // Event Details Section
          Flexible(
            flex: 7,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                widget.evm.selectEventIndex(widget.index);
                setState(() {});
              },
              child: Card(
                margin: const EdgeInsets.fromLTRB(5, 10, 10, 5),
                color: isEventPast? greyText.withOpacity(0.2): Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: AnimatedContainer(
                  duration: duration,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Event Title
                      Positioned(
                        top: 20,
                        right: 20,
                        child: AutoSizeText(
                          widget.event.name!,
                          textAlign: TextAlign.center,
                          maxFontSize: 28,
                          minFontSize: 16,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textDarkBlue,
                          ),
                        ),
                      ),
                      // Event Venue
                      Positioned(
                        top: 45,
                        right: 20,
                        child: Text(
                          widget.event.venue!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: blurBlue,
                          ),
                        ),
                      ),
                      // Event Description
                      Positioned(
                        top: 74,
                        right: 0,
                        child: AnimatedContainer(
                          duration: duration,
                          height: expanded ? 0 : 160,
                          width: MediaQuery.of(context).size.width - 120,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              utf8.decode(
                                  widget.event.description!.runes.toList()),
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteThis extends StatelessWidget {
  const DeleteThis({
    super.key,
    required this.expanded,
    required this.isEventPast,
    required this.startTime,
  });

  final bool expanded;
  final bool isEventPast;
  final DateTime startTime;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isEventPast
              ? LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(expanded ? 0xff268CCB : 0x33268CCB),
                    Color(expanded ? 0xff003D63 : 0x66003D63),
                  ],
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              startTime.day.toString(),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color:Colors.white ,
              ),
            ),
            Text(
              DateFormat('MMMM').format(startTime),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: expanded ? Colors.white : textDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
