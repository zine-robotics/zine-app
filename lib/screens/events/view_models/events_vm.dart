import "package:flutter/material.dart";
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';

final logger = customLogger();

class EventsVm extends ChangeNotifier {
  //====================================NEWER CODE=========================================//
  final eventRepo = EventsRepo();
  List<Events> _tempEvents = [];
  List<Events> get tempEvents => _tempEvents;

  Future<void> tempGetAllEvent() async {
    logger.i("Fetching events");
    try {
      _tempEvents = await eventRepo.fetchEvents();
      _tempEvents.sort((a, b) => b.startDateTime!.compareTo(a.startDateTime!));
      logger.i("Fetched events successfully");
      logger.d("Fetched events: ${_tempEvents.length}");
    } catch (e) {
      logger.e('Error fetching events: $e');
    } finally {
      notifyListeners();
    }
  }

  //====================================OLDER CODE=========================================//

  dynamic prev = 0;
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
