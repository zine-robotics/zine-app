import 'package:flutter/material.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:intl/intl.dart';

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
    double compressedHeight = availableHeight / 6;
    double expandedHeight = availableHeight / 3.2;
    bool expanded = !(widget.evm.selectedEvent == widget.event);
    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.maxFinite,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            widget.evm.selectEventIndex(widget.index);
            setState(() => expanded = !expanded);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: AnimatedContainer(
                  // decoration: BoxDecoration(image: DecorationImage(image: AssetImage(bundle: ))),
                  duration: Duration(milliseconds: 250),
                  width: double.maxFinite,
                  height: expanded ? compressedHeight : expandedHeight,
                  child: Stack(alignment: Alignment.center, children: [
                    widget.index.isEven
                        ? AnimatedPositioned(
                            duration: Duration(milliseconds: 250),
                            left: expanded ? 30 : 0,
                            right: expanded ? 0 : 280,
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              'assets/event_card_bg.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : AnimatedPositioned(
                            duration: Duration(milliseconds: 250),
                            right: expanded ? 30 : 0,
                            left: expanded ? 0 : 280,
                            top: 0,
                            bottom: 0,
                            child: Image.asset(
                              'assets/event_card_bg_rev.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned.fill(
                      left: widget.index.isEven ? 40 : null,
                      right: widget.index.isEven ? null : 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.event.timeDate!.toDate().day.toString(),
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: expanded ? textDarkBlue : Colors.white),
                          ),
                          Text(
                            DateFormat('MMMM')
                                .format(widget.event.timeDate!.toDate()),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: expanded ? textDarkBlue : Colors.white),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: 20,
                        left: widget.index.isEven ? null : 20,
                        right: widget.index.isEven ? 20 : null,
                        child: Text(
                          widget.event.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: expanded ? Colors.white : textDarkBlue),
                        )),
                    Positioned(
                        top: 60,
                        left: widget.index.isEven ? null : 20,
                        right: widget.index.isEven ? 20 : null,
                        child: Text(
                          widget.event.venue!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: expanded ? Colors.white : blurBlue),
                        )),
                    Positioned(
                        top: 100,
                        left: widget.index.isEven ? null : 20,
                        right: widget.index.isEven ? 20 : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: expanded ? 0 : 130,
                          width: MediaQuery.of(context).size.width - 20 - 160,
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  widget.event.description!,
                                  overflow: TextOverflow.fade,
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
            ),
          ),
        ));
  }
}