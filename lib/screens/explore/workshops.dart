import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/common/loaderScreen.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';
import 'package:zineapp2023/screens/explore/view_model/timeline_vm.dart';
import 'package:zineapp2023/screens/explore/workshop_tile.dart';

import '../../../theme/color.dart';
import '../../components/gradient.dart';
import '../../models/user.dart';
import 'coming_soon.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<Language, UserProv, TimelineVm, DashboardVm>(
      builder: (context, dict, userProv, timeLineVm, dashVm, _) {
        UserModel currUser = userProv.getUserInfo;
        // print("list events length:${timeLineVm.listEvents.length})");
        return timeLineVm.isLoading
            ? const Loader()
            :ComingSoon();
            // : Scaffold(
            //     bottomNavigationBar:
            //         (currUser.registered != null && currUser.registered as bool)
            //             ? null
            //             : Container(
            //                 color: backgroundGrey,
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(20.0),
            //                   child: ElevatedButton(
            //                     onPressed: () {
            //                       dashVm.launchUrl(
            //                           "https://zine.co.in/workshops/registration");
            //                     },
            //                     style: ButtonStyle(
            //                       padding: MaterialStateProperty.all(
            //                           const EdgeInsets.all(20.0)),
            //                       backgroundColor:
            //                           MaterialStateProperty.all(textColor),
            //                       shape: MaterialStateProperty.all<
            //                           RoundedRectangleBorder>(
            //                         RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(28.0),
            //                         ),
            //                       ),
            //                     ),
            //                     child: const Text(
            //                       "Register",
            //                       style: TextStyle(
            //                           fontSize: 20.0,
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //     backgroundColor: backgroundGrey,
            //     appBar: AppBar(
            //       elevation: 0,
            //       centerTitle: true,
            //       toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            //       title: const Text(
            //         "Recruitment",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 25,
            //           fontWeight: FontWeight.w900,
            //           letterSpacing: 1,
            //         ),
            //       ),
            //       flexibleSpace: Container(
            //         decoration: const BoxDecoration(
            //             gradient: mainGrad //need to replace with made component
            //             ),
            //       ),
            //     ),
            //     body: SingleChildScrollView(
            //       child: Padding(
            //         padding: const EdgeInsets.all(10),
            //         child: Column(
            //           children: [
            //             for (int i = 1;
            //                 i <= timeLineVm.sortedEvents.length;
            //                 i++)
            //               WorkshopTile(
            //                 events: timeLineVm.sortedEvents[i]!,
            //               )
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
      },
    );
  }
}
