import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/string_formatters.dart';
import 'package:intl/intl.dart';
import '../../common/routing.dart';
import '../../models/task_instance.dart';
import '../../utilities/date_time.dart';
import '../chat/chat_screen/chat_view.dart';
import '../tasks/view_models/task_vm.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsVm>(context, listen: false).tempGetAllEvent();
      Provider.of<ChatRoomViewModel>(context, listen: false).loadRooms();
      Provider.of<TaskVm>(context, listen: false).getTaskInstances();
    });
  }

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);
    return Consumer5<DashboardVm, UserProv, EventsVm, ChatRoomViewModel,TaskVm>(
      builder: (context, dashboardVm, userProv, eventVm, chatVm, taskVm,_) {
        // dashboardVm.getRecentEvent();
        UserModel currUser = userProv.getUserInfo;
        List<UserTaskInstance> taskInstancesList=taskVm.taskInstances;
        int allChatRoom=chatVm.allChatRoom;
        // eventVm.tempGetAllEvent();

        return Scaffold(
          extendBody: true,
          body: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: backgroundGrey,
              ),
              height: double.infinity,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .push(Routes.profileScreen());
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
                          child: Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("Hi",
                                      style: TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff646464))),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(currUser.name.toString().firstName(),
                                      style: const TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff0C72B0))),
                                ],
                              ),
                              const Spacer(),
                              buildProfilePicture(currUser.dp,size:30),
                              // CircleAvatar(
                              //   radius: 30,
                              //   backgroundColor: iconTile,
                              //   backgroundImage: AssetImage(
                              //     "assets/images/dp/${currUser.dp}.png",
                              //   ),
                              // ),
                              const SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      // * Priyansh ko Gaaliya :) *

                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                      //   child: Text("EVENTS",
                      //       style: TextStyle(
                      //           height: 0.9,
                      //           letterSpacing: 0.3,
                      //           fontSize: 20.0,
                      //           fontWeight: FontWeight.w700,
                      //           color: greyText)),
                      // ),
                      // const SizedBox(
                      //   height: 0,
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(Routes.publicEvents()),
                                  child: Container(
                                    height: availableHeight * 0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 25, 0),
                                          child: Text(
                                            10 <= DateTime.now().day &&
                                                    DateTime.now().day <= 20
                                                ? "TH"
                                                : DateTime.now().day % 10 == 1
                                                    ? "ST"
                                                    : DateTime.now().day % 10 ==
                                                            2
                                                        ? "ND"
                                                        : DateTime.now().day %
                                                                    10 ==
                                                                3
                                                            ? "RD"
                                                            : "TH",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    15,
                                                color: const Color(0xff0C72B0)),
                                          ),
                                        ),
                                        Text(
                                          DateTime.now().day.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  60,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff0C72B0)),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          DateFormat('MMM')
                                              .format(DateTime.now())
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  40,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xffa3d0ec)),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context)
                                      .push(Routes.publicEvents())
                                },
                                child: Container(
                                  // height: 200,
                                  height: availableHeight * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        eventVm.tempEvents.length != 0
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      eventVm.tempEvents.length != 0
                                          ? Text(
                                              eventVm.tempEvents[0].type
                                                  .toString(),
                                              style: const TextStyle(
                                                  height: 0.9,
                                                  letterSpacing: 0.3,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xff646464)))
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Text(
                                                  "No Upcoming Events",
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: MediaQuery.of(
                                                                  context)
                                                              .textScaleFactor *
                                                          25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: greyText),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      eventVm.tempEvents.length != 0
                                          ? Text(
                                              eventVm.tempEvents[0].name
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff0C72B0)),
                                              textAlign: TextAlign.center,
                                            )
                                          : Container(),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      eventVm.tempEvents.length != 0
                                          ? Container(
                                              margin: const EdgeInsets.all(5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              height: availableHeight *
                                                  0.3 *
                                                  0.5, // Half of previous height
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(24.0),
                                                    bottomRight:
                                                        Radius.circular(24.0)),
                                                color: Color(0xff0C72B0),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    eventVm.tempEvents.length >
                                                            0
                                                        ? DateFormat.MMMMd().format(
                                                            convertTimestamp(eventVm
                                                                .tempEvents[0]
                                                                .startDateTime!))
                                                        : "Date",
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromARGB(
                                                            200,
                                                            255,
                                                            255,
                                                            255)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  AutoSizeText(
                                                    eventVm.tempEvents[0]
                                                                .startDateTime !=
                                                            null
                                                        ? '${DateFormat.jm().format(convertTimestamp(eventVm.tempEvents[0].startDateTime!))} \n ${eventVm.tempEvents[0].venue.toString()}'
                                                        : '',
                                                    maxFontSize: 18,
                                                    minFontSize: 10,
                                                    style: const TextStyle(
                                                        // fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            // height: 200,
                            height: availableHeight * 0.3,
                            viewportFraction: 0.87),
                        items: [
                          "ALGORITHMS",
                          "BEE",
                          "BME",
                          "AEROMODELLING",
                          "IC-MCU",
                          // "CYBERSECURITY",
                          "WEB DEVELOPMENT",
                          "MACHINE LEARNING"
                        ].map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    dashboardVm.launchUrl(
                                        'https://zine.co.in/blogs/${DashboardVm.routes[i]!.toLowerCase()}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.5, vertical: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/blog_card.png")),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                      child: Center(
                                        child: Text(
                                          i,
                                          style: const TextStyle(
                                              height: 0.9,
                                              letterSpacing: 0.3,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w600,
                                              color: textColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.45,
                              height: availableHeight * 0.18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(Routes.tasks())
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    taskInstancesList.length!= 0
                                        ? Text(
                                      taskInstancesList.length.toString(),
                                            style: const TextStyle(
                                                height: 0.9,
                                                letterSpacing: 0.3,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w600,
                                                color: greyText),
                                            textAlign: TextAlign.center,
                                          )
                                        : const Text(
                                            "0",
                                            style: TextStyle(
                                                height: 0.9,
                                                letterSpacing: 0.3,
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w600,
                                                color: greyText),
                                            textAlign: TextAlign.center,
                                          ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Tasks",
                                        style: TextStyle(
                                            height: 0.9,
                                            letterSpacing: 0.3,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: greyText)),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).push(Routes.chatHome())
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.45,
                                height: availableHeight * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      // userProv.currUser.roomids!.length
                                      allChatRoom != 0
                                          ? allChatRoom.toString()
                                          : "0",
                                      style: const TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w600,
                                          color: textColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Chats",
                                        style: TextStyle(
                                            height: 0.9,
                                            letterSpacing: 0.3,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: greyText)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
