import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/screens/chat/chat_home.dart';

import 'package:zineapp2023/screens/explore/coming_soon.dart';
import 'package:zineapp2023/screens/explore/public_events/events_screen.dart';
import 'package:zineapp2023/screens/tasks/taskDesc.dart';

import '../screens/explore/achievements.dart';
import '../screens/explore/team/team.dart';
import '../screens/explore/explore.dart';
import '../screens/explore/workshops.dart';
import '../screens/home/home_screen.dart';
import '../screens/onboarding/landing.dart';
import '../screens/onboarding/reset_password/email_screen.dart';
import '../screens/dashboard/profile.dart';
import '../screens/explore/about/about.dart';
import '../screens/explore/project.dart';
import '../screens/events/events.dart';

/// This file contains the routes to different screens. Please create a new route
/// for the router to use here or else you'll have to route directly to the screen
/// you made.
///
/// This just avoids boilerplate code and just reduces a single line of code from
/// everywhere you route from.
///
/// Note: This file creates static routes which is overall better.

class RouteName {
  static const landingScreen = "landingScreen";
  static const teamScreen = "team";
  static const achievementScreen = "achievement";
  static const projectScreen = "project";
  static const aboutMe = "about";
  static const wokrshopTimeline = "workshop";
  static const exploreScreen = "explore";
  static const homeScreen = "home";
  static const profileScreen = "profile";
  static const emailScreen = "email";
  static const chatHome = "chatHome";
  static const eventName = "eventName";
  static const tasks = "tasks";
  static const taskDesc = "taskDesc";
  static const comingSoon = "comingSoon";
  static const eventCalender = "eventCalender";
  // static const dashboard = "dashboard";
  static const publicEvents = "publicEvents";
}

class Routes {
  //Simplification for easier fucntion usage down below
  static cupertinoRoute(
          String name, Widget Function(BuildContext) widgetProvider) =>
      CupertinoPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) => widgetProvider(context),
      );

  static Route landingScreen() =>
      cupertinoRoute(RouteName.landingScreen, (ctx) => const LandingScreen());

  static Route homeScreen() =>
      cupertinoRoute(RouteName.homeScreen, (ctx) => const Home());

  static Route teamScreen() => cupertinoRoute(
        RouteName.teamScreen,
        (ctx) => const TeamScreen(),
      );

  static Route achievementScreen() => cupertinoRoute(
      RouteName.achievementScreen, (ctx) => const AchievementScreen());

  static Route projectScreen() =>
      cupertinoRoute(RouteName.projectScreen, (ctx) => const ProjectScreen());

  static Route aboutMe() =>
      cupertinoRoute(RouteName.aboutMe, (ctx) => const AboutScreen());

  static Route chatHome() =>
      cupertinoRoute(RouteName.chatHome, (ctx) => const ChatHome());

  static Route tasks() =>
      cupertinoRoute(RouteName.tasks, (ctx) => const ChatHome());

  static Route Event({DateTime? selectedDate}) =>
      cupertinoRoute(RouteName.eventName, (ctx) => const Events());

  static Route publicEvents() {
    print("hi");
    return cupertinoRoute(RouteName.publicEvents, (ctx) => EventsScreen());
  }

  static Route taskDesc() =>
      cupertinoRoute(RouteName.taskDesc, (ctx) => TaskDesc());

  static Route workshopTimeline() => cupertinoRoute(
      RouteName.wokrshopTimeline, (ctx) => const WorkshopScreen());

  static Route comingSoon() =>
      cupertinoRoute(RouteName.exploreScreen, (ctx) => const ComingSoon());

  static Route exploreScreen() =>
      cupertinoRoute(RouteName.exploreScreen, (ctx) => const Explore());

  static Route profileScreen() =>
      cupertinoRoute(RouteName.profileScreen, (ctx) => const ProfileScreen());

  static Route emailScreen() =>
      cupertinoRoute(RouteName.emailScreen, (ctx) => EmailScreen());
 static Route eventCalender() =>
     cupertinoRoute(RouteName.emailScreen, (ctx) => EmailScreen());

}
