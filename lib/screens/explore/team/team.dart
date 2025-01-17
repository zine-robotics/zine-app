import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:zineapp2023/components/widgets.dart';
import '../../../components/gradient.dart';
import '../../../components/tab_tiles.dart';
import '../../../screens/explore/team/team_tile.dart';
import '../../../providers/dictionary.dart';
import '../../../theme/color.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  static const year = ["second", "third", "fourth"];

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
      builder: (context, dict, _) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: backgroundGrey,
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35.0))),
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              flexibleSpace: Container(
                  decoration: const BoxDecoration(gradient: mainGrad)),
              centerTitle: true,
              title: appbarTitle("Team"),
              bottom: const TabBar(
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 20),
                unselectedLabelStyle: TextStyle(fontSize: 20),
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 4,
                      color: Colors.white,
                    ),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                tabs: [
                  WhiteTabTile(label: "2nd Year"),
                  WhiteTabTile(label: "3rd Year"),
                  WhiteTabTile(label: "4th Year"),
                  // WhiteTabTile(label: "5th Year"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // TabBarView Creates views with one child per Tab (each ListView.Builder)
                for (int i = 0; i < 3; i++)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dict.teamScreen.team![i].length + 1,
                    itemBuilder: (context, index) {
                      return index == dict.teamScreen.team![i].length
                          ? const SizedBox(
                              height: 10.0,
                            )
                          : TeamTile(
                              year: year[i],
                              image: dict.teamScreen.team![i][index].image!,
                              name: dict.teamScreen.team![i][index].name!,
                              id: dict.teamScreen.team![i][index].email!,
                              bio: dict.teamScreen.team![i][index].bio!,
                              linkedin:
                                  dict.teamScreen.team![i][index].linkedIn!,
                              branch: dict.teamScreen.team![i][index]
                                  .branch! //=null? dict.teamScreen.team![i][index].branch! : " "

                              );
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
