// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/explore/public_events/event_calendar.dart';
import 'package:zineapp2023/screens/explore/public_events/event_tile.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool isEven(int index) {
    return index % 2 == 0;
  }

  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PublicEventsVM>(context, listen: false).loadEvents();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // final List<Events> dummyEvents = [
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);

    return Scaffold(
      // backgroundColor: backgroundGrey.withOpacity(0.7),
      backgroundColor: Colors.white.withOpacity(0.95),

      body: Consumer<PublicEventsVM>(
        builder: (context, evm, _) {
          if (evm.events.isNotEmpty && _controller.hasClients) {
            _controller.animateTo(evm.selectedIndex * 100,
                curve: Curves.easeInOut, duration: Duration(milliseconds: 250));
            evm.loadEvents();
          }
          print("evm.events:${evm.events.length}");
          return SafeArea(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.025, right: screenWidth * 0.025),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [BoxShadow(color:textColor,spreadRadius: 10,blurRadius: 10 )]
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5.0, left: 0, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (Navigator.canPop(context))
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: greyText,
                                  size: 40,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            // Title text
                            Expanded(
                              child: Text(
                                "Events Calendar",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  color: greyText,
                                ),
                              ),
                            ),
                            // To balance spacing with the back button (optional)
                            // SizedBox(width: 48), // Empty space the same size as the icon
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: availableHeight / 2,
                    // color: Colors.white.withOpacity(0.3),
                    // padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          color: Colors.white,
                        ),

                        // elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: EventCalendar(
                            evm: evm,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  (evm.events.isNotEmpty)
                      ? Expanded(
                          child: ListView.builder(
                          controller: _controller,
                          itemBuilder: (context, index) {
                            return EventTile(
                              evm: evm,
                              index: index,
                              event: evm.events[index],
                            );
                          },
                          itemCount: evm.events.length,
                        ))
                      : Expanded(
                          child: Center(
                            child: Text(
                              'Something\'s cooking. . .',
                              style: TextStyle(
                                  height: 0.9,
                                  letterSpacing: 0.3,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  color: greyText),
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
