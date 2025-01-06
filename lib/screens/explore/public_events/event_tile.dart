import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);
    double compressedHeight = availableHeight / 7;
    double expandedHeight = availableHeight / 3.2;
    bool isEventPast=widget.event.startDateTime !=null? isPastEvent(widget.event.startDateTime! ):true;
    bool expanded = !(widget.evm.expandedEvent == widget.event);
    const duration = Duration(milliseconds: 250);
    return AnimatedContainer(
        duration: duration,
        width: double.maxFinite,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            widget.evm.selectEventIndex(widget.index);
            setState(() {});
          },
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: AnimatedContainer(
              height: expanded ? compressedHeight : expandedHeight,
              // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(bundle: ))),
              duration: duration,
              // width: double.maxFinite,
              // constraints: BoxConstraints(
              //     maxWidth: double.maxFinite,
              //     minHeight: compressedHeight,
              //     maxHeight: expandedHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), // Ensure the radius matches the card

                gradient: isEventPast? const LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color(0xaaf0f0f0), // Light Gray
                    Color(0xff909090), // Dark Gray
                  ],
                ): null,
              ),
              child: Stack(alignment: Alignment.center, children: [
                // widget.index.isEven
                // AnimatedPositioned(
                //   duration: duration,
                //   left: expanded ? 30 : 0,
                //   right: expanded ? 0 : 280,
                //   top: 0,
                //   bottom: 0,
                //   child: Image.asset(
                //     alignment: Alignment.topLeft,
                //     'assets/event_card_bg.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // : AnimatedPositioned(
                //     duration: duration,
                //     right: expanded ? 30 : 0,
                //     left: expanded ? 0 : 280,
                //     top: 0,
                //     bottom: 0,
                //     child: Image.asset(
                //       'assets/event_card_bg_rev.png',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                Positioned(
                  left: 15,
                  // left: widget.index.isEven ? 25 : null,
                  // right: widget.index.isEven ? null : 25,
                  child: Container(
                    width: 85,height: 85,
                    decoration: expanded ?BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: !isEventPast? const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color(0xff268CCB), // Light blue
                          Color(0xff003D63), // Dark blue
                        ],
                      ):const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color(0x33268CCB), // Light blue
                          Color(0x66003D63), // Dark blue
                        ],
                      ),

                    ): BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  widget.event.startDateTime!)
                              .day
                              .toString(),
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              // color: expanded ? textDarkBlue : Colors.white),
                              color:expanded ? Colors.white:textDarkBlue ),
                        ),
                        Text(
                          DateFormat('MMMM').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.event.startDateTime!)),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: expanded ? textDarkBlue : Colors.white),
                              color: expanded? Colors.white:textDarkBlue),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 20,
                    // left: widget.index.isEven ? null : 20,
                    // right: widget.index.isEven ? 20 : null,
                    right: 20,
                    child: AutoSizeText(
                      widget.event.name!,
                      textAlign: TextAlign.center,
                      maxFontSize: 28,
                      minFontSize: 16,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textDarkBlue),
                      // color: expanded ? Colors.white : textDarkBlue),
                    )),
                Positioned(
                    top: 60,
                    // left: widget.index.isEven ? null : 20,
                    // right: widget.index.isEven ? 20 : null,
                    right: 20,
                    child: Text(
                      widget.event.venue!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          // color: expanded ? Colors.white : blurBlue),
                          color: blurBlue),
                    )),
                Positioned(
                    top: 100,
                    // left: widget.index.isEven ? null : 20,
                    // right: widget.index.isEven ? 20 : null,
                    right: 0,
                    child: AnimatedContainer(
                      duration: duration,
                      height: expanded ? 0 : 140,
                      width: MediaQuery.of(context).size.width - 170,
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              "${utf8.decode((widget.event.description!).runes.toList())}",
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontFamily: 'Roboto'),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Center(
                          //   child: ElevatedButton(
                          //       clipBehavior: Clip.hardEdge,
                          //       onPressed: () {},
                          //       child: Icon(
                          //         Icons.calendar_today,
                          //         color: textColor,
                          //       )),
                          // )
                        ],
                      ),
                    ))
              ]),
            ),
          ),
        ));
  }
}
