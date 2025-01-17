import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/database/database.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/explore/public_events/events_screen.dart';
import 'view_models/home_view_model.dart';

import '../explore/explore.dart';
import '../../screens/chat/chat_home.dart';
import '../../screens/dashboard/dashboard.dart';
import '../../theme/color.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    var chatRoomView = Provider.of<ChatRoomViewModel>(context, listen: false);
    var db = Provider.of<AppDb>(context, listen: false);
    chatRoomView.fetchAllRoomDataFromLocalDB(db);
    chatRoomView.fetchAllRoomDataFromApiAndSyncWithDB(db);
    // Initialize the PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, homeVm, _) {
      return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: homeVm.onItemTapped,
          //     (index){
          //   homeVm.onItemTapped(index);
          // },
          children: <Widget>[
            const ChatHome(),
            const Explore(),
            EventsScreen(),
            const Dashboard(),
          ],
        ),
        extendBody: false,
        backgroundColor: backgroundGrey,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
          child: Container(
            // Adjust the margin as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  blurRadius: 42.0,
                  color: backgroundGrey,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.message,
                        color: blurBlue,
                        size: 20,
                      ),
                      activeIcon: DecoratedIcon(
                        FontAwesomeIcons.solidMessage,
                        size: 22,
                        color: textColor,
                        shadows: [
                          BoxShadow(
                            blurRadius: 42.0,
                            color: blurBlue,
                          ),
                        ],
                      ),
                      label: 'Timeline',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        color: blurBlue,
                      ),
                      activeIcon: DecoratedIcon(
                        Icons.home,
                        color: textColor,
                        shadows: [
                          BoxShadow(
                            blurRadius: 42.0,
                            color: blurBlue,
                          ),
                        ],
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.calendar_month_outlined,
                        color: blurBlue,
                      ),
                      activeIcon: DecoratedIcon(
                        Icons.calendar_month_rounded,
                        color: textColor,
                        shadows: [
                          BoxShadow(
                            blurRadius: 42.0,
                            color: blurBlue,
                          ),
                        ],
                      ),
                      label: 'Events',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: blurBlue,
                      ),
                      activeIcon: DecoratedIcon(
                        Icons.account_circle,
                        color: textColor,
                        shadows: [
                          BoxShadow(
                            blurRadius: 42.0,
                            color: blurBlue,
                          ),
                        ],
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: homeVm.selectedIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  unselectedIconTheme: const IconThemeData(size: 25.0),
                  selectedIconTheme: const IconThemeData(size: 30.0),
                  onTap: (index) {
                    homeVm.onItemTapped(index);
                    // _pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInCubic);
                    _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate);
                  }
                  //homeVm.onItemTapped,
                  ),
            ),
          ),
        ),
      );
    });
  }
}
