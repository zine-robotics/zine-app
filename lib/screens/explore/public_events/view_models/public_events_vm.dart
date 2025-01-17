import 'dart:core';
import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';
import 'package:table_calendar/src/shared/utils.dart';
import 'package:zineapp2023/models/events.dart';

//TODO: Delete this file Not Require use Events VM
class PublicEventsVM extends ChangeNotifier {
  // final PublicEventsRepo peRepo = PublicEventsRepo();
  final EventsRepo eventsRepo = EventsRepo();
  List<Events> _events = [];
  static var nullEvent = Events(name: 'null', startDateTime: DateTime.now());
  Events _selectedEvent = nullEvent; //defualt Selected Event
  Events _expandedEvent = nullEvent;
  int _selectedIndex = -1;
  int _expandedIndex = -1;
  var _isLoaded = false;
  var _isError = false;

  void reloadEvents() {}

  void loadEvents() async {
    if (_isLoaded) return;
    try {
      List<Events> tempEvents = await eventsRepo.fetchEvents();
      // List<Events> tempEvents = dummyEvents;

      tempEvents.sort((b, a) => b.startDateTime!.compareTo(a.startDateTime!));
      _events = tempEvents;
      for (var event in _events) {
        DateTime eventDate = event.startDateTime!;
        print("Event Date: ${eventDate.toString()}");
      }
    } catch (e) {
      print("Error $e");
      _isError = true;
    }

    _isLoaded = true;

    notifyListeners();
  }

  void selectEvent(DateTime selectedDay, DateTime focusedDay) {
    var index = _events
        .indexWhere((event) => isSameDay(event.startDateTime!, selectedDay));
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

  Events get selectedEvent => _selectedEvent;
  Events get expandedEvent => _expandedEvent;
  int get selectedIndex => _selectedIndex;
  int get expandedIndex => _expandedIndex;

  bool get isError => _isError;
  bool get isLoaded => _isLoaded;
  List<Events> get events => _events;

  DateTime getLastEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<Events> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev1.startDateTime!.compareTo(ev2.startDateTime!));
    return (evCopy.last.startDateTime!);
  }

  DateTime getFirstEventDate() {
    if (_events.isEmpty) return DateTime.now();
    List<Events> evCopy = List.from(_events);
    evCopy.sort((ev1, ev2) => ev2.startDateTime!.compareTo(ev1.startDateTime!));
    return (evCopy.last.startDateTime!);
  }

  List<Events> getEvents(DateTime day) =>
      _events.where((event) => isSameDay((event.startDateTime!), day)).toList();
}
