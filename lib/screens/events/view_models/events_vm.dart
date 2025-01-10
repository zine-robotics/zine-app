import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

class EventsVm extends ChangeNotifier {
  //====================================NEWER CODE=========================================//
  final eventRepo = EventsRepo();
  List<Events> _tempEvents = [];
  List<Events> get tempEvents => _tempEvents;

  Future<void> tempGetAllEvent() async {
    print("inside the getallevents");
    try {

      _tempEvents = await eventRepo.fetchEvents();
      _tempEvents.sort((a, b) => b.startDateTime!.compareTo(a.startDateTime!));
      print("sorted Events:${_tempEvents}");
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      notifyListeners();
    }
  }

  //====================================OLDER CODE=========================================//

  List<Events> _events = [];
  dynamic prev = 0;
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

}
