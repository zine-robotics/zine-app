import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/temp_events.dart';
import 'package:zineapp2023/models/temp_message.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';
import 'package:zineapp2023/screens/explore/public_events/repo/public_events_repo.dart';
import 'package:table_calendar/src/shared/utils.dart';
import 'package:zineapp2023/models/events.dart';

class PublicEventsVM extends ChangeNotifier {
  // final PublicEventsRepo peRepo = PublicEventsRepo();
  final EventsRepo eventsRepo = EventsRepo();
  List<TempEvents> _events = [];
  static var nullEvent = TempEvents(
      name: 'null', startDateTime: DateTime.now().millisecondsSinceEpoch);
  TempEvents _selectedEvent = nullEvent; //defualt Selected Event
  TempEvents _expandedEvent = nullEvent;
  int _selectedIndex = -1;
  int _expandedIndex = -1;
  var _isLoaded = false;
  var _isError = false;

  void loadEvents() async {
    if (_isLoaded) return;
    try {
      List<TempEvents> tempEvents = await eventsRepo.fetchEvents();
      _events = tempEvents;
    } catch (e) {
      print("Error $e");
      _isError = true;
    }

    // try {
    //   List<Events> fireEvents = await peRepo.getEvents();
    //   _events = fireEvents;
    // } catch (e) {
    //   print("Error $e");
    //   _isError = true;
    // }
    _isLoaded = true;

    notifyListeners();
  }

  void selectEvent(DateTime selectedDay, DateTime focusedDay) {
    var index = _events.indexWhere((event) => isSameDay(
        DateTime.fromMillisecondsSinceEpoch(event.startDateTime!),
        selectedDay));
    if (index >= 0) {
      _selectedEvent = _events[index];
      _selectedIndex = index;
    }
    notifyListeners();
  }

  void toggleExpansion() {
    if (_expandedEvent == nullEvent) {
      _expandedEvent = _selectedEvent;
      _expandedIndex = _selectedIndex;
    } else {
      _expandedEvent = nullEvent;
      _expandedIndex = -1;
    }
  }

  void selectEventIndex(int index) {
    _selectedEvent = _events[index];
    _selectedIndex = index;
    toggleExpansion();
    notifyListeners();
  }

  TempEvents get selectedEvent => _selectedEvent;
  TempEvents get expandedEvent => _expandedEvent;
  int get selectedIndex => _selectedIndex;
  int get expandedIndex => _expandedIndex;

  bool get isError => _isError;
  bool get isLoaded => _isLoaded;
  List<TempEvents> get events => _events;

  DateTime getLastEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<TempEvents> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev1.startDateTime!.compareTo(ev2.startDateTime!));
    return DateTime.fromMillisecondsSinceEpoch(evCopy.last.startDateTime!);
  }

  DateTime getFirstEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<TempEvents> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev2.startDateTime!.compareTo(ev1.startDateTime!));
    return DateTime.fromMillisecondsSinceEpoch(evCopy.last.startDateTime!);
  }

  List<TempEvents> getEvents(DateTime day) => _events
      .where((event) => isSameDay(
          DateTime.fromMillisecondsSinceEpoch(event.startDateTime!), day))
      .toList();
}
