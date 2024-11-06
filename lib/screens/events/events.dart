import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/events/eventCard.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class Events extends StatelessWidget {
  final selectedDate;
  const Events({Key? key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventsVm, DashboardVm>(
        builder: (context, eventsVm, dashVm, _) {
      // eventsVm.getAllEvents();

      var tempEvents = eventsVm.tempEvents;
      // var events = eventsVm.events;
      print("tempevents in events:${tempEvents[0].recruitment?.id}");

      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0,
          centerTitle: true,
          backgroundColor: backgroundGrey,
          leading: GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Image.asset(
              "assets/images/backbtn.png",
              height: 30,
            ),
          ),
          title: Text(
            eventsVm.tempEvents.length != 0 ? "EVENT" : "Past Events",
            style: const TextStyle(
              height: 0.9,
              letterSpacing: 0.3,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(225, 34, 33, 33),
            ),
          ),
        ),
        body: eventsVm.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: const BoxDecoration(
                  color: backgroundGrey,
                ),
                height: double.infinity,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Text("checkDate :${checkDate.day}"),
                        for (int i = tempEvents.length - 1; i >= 0; i--)
                          // if (tempEvents[i].recruitment?.id == 1 )
                          EventCard(
                            // event: events[i],
                            tempEvent: tempEvents[i],
                            selectedDate: selectedDate,
                          )
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
