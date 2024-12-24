import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class EventCalendar extends StatelessWidget {
  const EventCalendar({super.key, required this.evm});
  final PublicEventsVM evm;

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);
    return TableCalendar(

      calendarStyle: const CalendarStyle(
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: Color(0xbb003D63),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xbb0c72b0),
          )),
      eventLoader: evm.getEvents,
      focusedDay: !(evm.isLoaded && !evm.isError && evm.events.isNotEmpty)
          ? DateTime.now()
          : evm.getFirstEventDate(),
      selectedDayPredicate: (day) {
        if (evm.isError || !evm.isLoaded || evm.events.isEmpty) {
          return false;
        } else {
          return isSameDay(
              DateTime.fromMillisecondsSinceEpoch(
                  evm.selectedEvent.startDateTime!),
              day);
        }
      },
      firstDay: evm.getFirstEventDate(),
      // firstDay: DateTime.now(),
      lastDay: evm.getLastEventDate(),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Roboto',color: textColor),
        weekdayStyle: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Verdana',color: textColor),


      ),

      onDaySelected: evm.selectEvent,
      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(
            color: textColor, fontWeight: FontWeight.bold, fontSize: 28),
        rightChevronVisible: true,
        leftChevronVisible: true,
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Container(decoration: BoxDecoration(color:
        textColor,
        borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.chevron_left_rounded,color: Colors.white,),),
        rightChevronIcon: Container(decoration: BoxDecoration(color:
        textColor,
        borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.chevron_right,color: Colors.white,),),

      ),
    );
  }
}
