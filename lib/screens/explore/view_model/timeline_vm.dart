import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/screens/events/repo/events_repo.dart';

import '../../../common/routing.dart';

class TimelineVm extends ChangeNotifier {
  final EventsRepo eventRepo = EventsRepo();
  Map<int, List<Events>> sortedEvents = {};
  bool isLoading = false;

  Future<dynamic> routeMe(BuildContext context, String route) async {
    switch (route) {
      case RouteName.teamScreen:
        await Navigator.of(context).push(Routes.teamScreen());
        break;
      case RouteName.aboutMe:
        await Navigator.of(context).push(Routes.aboutMe());
        break;
      case RouteName.projectScreen:
        await Navigator.of(context).push(Routes.projectScreen());
        break;
      case RouteName.achievementScreen:
        await Navigator.of(context).push(Routes.achievementScreen());
        break;
      case RouteName.wokrshopTimeline:
        await Navigator.of(context).push(Routes.workshopTimeline());
        break;
      case RouteName.publicEvents:
        await Navigator.of(context).push(Routes.publicEvents());
        break;
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void getStagesEvents() async {
    setLoading(true);
    // List<Events> list = await eventRepo.getEvents();
    List<Events> list = await eventRepo.fetchEvents();
    list.sort((b, a) => b.startDateTime!.compareTo(a.startDateTime!));
    List<Events> recruitmentEvents =
        list.where((element) => element.recruitment != null).toList();

    // for (int i = 1; i <= list.length; i++) {
    //   List<dynamic>? subList = list
    //       .where((element) => element.stage == i.toString())
    //       .where((element) => element.recruitment == 'true')
    //       .toList();
    sortedEvents.clear();
    for (Events event in recruitmentEvents) {
      if (sortedEvents.containsKey(event.recruitment!.stage!)) {
        sortedEvents[event.recruitment!.stage!]!.add(event);
      } else {
        sortedEvents[event.recruitment!.stage!] = [event];
      }
    }

    setLoading(false);

    notifyListeners();
  }
}
