import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zineapp2023/models/newTask.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';

import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/theme/color.dart';

//NEEDS TO BE REVIEWD (Priority High)
class TaskDesc extends StatefulWidget {
  TaskDesc({super.key});

  @override
  State<TaskDesc> createState() => _TaskDescState();
}

final messageC = TextEditingController();
final headingC = TextEditingController();
final linkC = TextEditingController();
bool LinkValidate = false;
bool CheckpointValidate = false;

class _TaskDescState extends State<TaskDesc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TaskVm tvm = Provider.of<TaskVm>(context, listen: false);
    tvm.getCurrCheckpoints();
    tvm.getLinks();
  }

  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();

  List<bool> arr = [true, false, false];
  List<String> tempMessage = [];

  List<String> tempLink = [];
  List<String> tempHeader = [];

  // List<String> tempLink = [];
  // List<String> tempHeader = [];

  Widget descripWidget(BuildContext context) {
    return Consumer<TaskVm>(
      builder: (context, taskvm, _) {
        UserTaskInstance curr = taskvm.getCurr();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: arr[0] ? Colors.white : const Color(0xfffafafa),
                borderRadius: BorderRadius.circular(20.0)),
            // color: Colors.white,
            child: Column(
              children: [
                Card(
                  // margin: EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  color: const Color(0xFF268CCB),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          curr.task != null ? curr.task.title.toString() : "",
                          style: const TextStyle(
                            fontFamily: "Poppins-ExtraBold",
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        InkWell(
                          onTap: () {
                            // Add your link functionality here
                            launchUrl(Uri.parse(
                                curr.task.psLink.toString())); // Open the URL
                          },
                          child: const Row(
                            mainAxisSize:
                                MainAxisSize.min, // Keeps the Row compact
                            children: [
                              Icon(
                                Icons.link,
                                color: Colors
                                    .white, // Same color as the text for consistency
                                size: 16.0, // Adjust the size of the icon
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Problem Statement",
                                style: TextStyle(
                                  color: Colors.white, // Link color
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // Space between text and icon
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              // color: Color,
                              // color: Colors.white,
                              // color: Colors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 39.0, vertical: 12.0),
                                child: Text(
                                  curr.status.toString(),
                                  // 'In progress',
                                  style: const TextStyle(
                                    color: Color(0xFF268CCB),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              curr.task != null
                                  ? "${DateFormat(DateFormat.MONTH_DAY).format(curr.task.dueDate!)}\n${DateFormat.y().format(curr.task.dueDate!)}"
                                  : "",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ExpansionTileCard(
                  initiallyExpanded: true,
                  onExpansionChanged: (boolea) {
                    if (boolea) {
                      cardB.currentState?.collapse();
                      cardC.currentState?.collapse();
                      setState(() {
                        arr[0] = true;
                        arr[1] = false;
                        arr[2] = false;
                      });
                    } else {
                      setState(() {
                        arr[0] = false;
                        arr[1] = false;
                        arr[2] = false;
                      });
                    }
                  },
                  elevation: 0,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  key: cardA,
                  title: const Text(
                    'DESCRIPTION',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          curr.task.description!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget checkPointWidget(BuildContext context, List<Checkpoint> cheklist) {
    //print("chekpoint element are:${cheklist.toString()}");
    final taskVm = Provider.of<TaskVm>(context, listen: false);

    final dashVm = Provider.of<DashboardVm>(context, listen: false);
    UserProv userProv = Provider.of<UserProv>(context, listen: false);
    String userName = userProv.getUserInfo.name!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: ExpansionTileCard(
          onExpansionChanged: (boolea) {
            if (boolea) {
              cardA.currentState?.collapse();
              cardC.currentState?.collapse();

              setState(() {
                arr[0] = false;
                arr[1] = true;
                arr[2] = false;
              });
            } else {
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = false;
              });
            }
          },
          elevation: 0,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          // trailing: ,
          key: cardB,
          title: const Text(
            'CHECKPOINT',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 1.0,
                vertical: 10.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 250,
                //color: Colors.red,
                //color: Colors.red,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (Checkpoint check in cheklist)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${check.sentFrom ?? "Anonymus"} | ${DateFormat(DateFormat.HOUR24_MINUTE).format(check.timestamp)} :${DateFormat("dd MMM, yy").format(check.timestamp)}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11),
                              textAlign: check.remark
                                  ? TextAlign.left
                                  : TextAlign.right,
                            ),
                            Text(
                              '${check.content}\n',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 16,
                                      color: check.remark
                                          ? const Color.fromARGB(
                                              255, 5, 117, 186)
                                          : Colors.black),
                              textAlign: check.remark
                                  ? TextAlign.left
                                  : TextAlign.right,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              minLines: 1,
                              controller: messageC,
                              decoration: const InputDecoration(
                                  hintText: "Enter Checkpoints",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton(
                              splashRadius: 30.0,
                              visualDensity: const VisualDensity(
                                  horizontal: 4.0, vertical: 1.0),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (messageC.text.isNotEmpty) {
                                  taskVm.addCurrCheckpoints(
                                      messageC.text.toString());

                                  messageC.clear();
                                }
                              },
                              iconSize: 20.0,
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blue,
                                size: 24,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget linksWidget(BuildContext context) {
    TaskVm taskVm = Provider.of<TaskVm>(context, listen: true);
    List<Link> links = taskVm.currLinks;
    UserProv userProv = Provider.of<UserProv>(context, listen: false);
    print(links);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: ExpansionTileCard(
          onExpansionChanged: (boolea) {
            if (boolea) {
              cardA.currentState?.collapse();
              cardB.currentState?.collapse();
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = true;
              });
            } else {
              setState(() {
                arr[0] = false;
                arr[1] = false;
                arr[2] = false;
              });
            }
          },
          elevation: 0,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          key: cardC,
          title: const Text(
            'LINKS',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: [
                    if (links.isNotEmpty)
                      for (Link link in links)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(link.type,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                ),
                                Text(
                                    '${link.sentFrom ?? "Anonymus"} | ${DateFormat(DateFormat.HOUR24_MINUTE).format(link.timestamp)} :${DateFormat("dd MMM, yy").format(link.timestamp)}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 9)),
                              ],
                            ),
                            InkWell(
                                child: Text(
                                  link.link.toString(),
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.blue),
                                ),
                                onTap: () => launch(link.link.toString())),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      // Heading Input
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 2.0, bottom: 2.0),
                          child: TextField(
                            controller: headingC,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Heading',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 1, // Line thickness
                          height: 25, // Full height of the parent widget
                          color: Colors.blue), // Change to your desired color

                      // Link Input
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: linkC,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Link',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      // Send Button
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Transform.scale(
                          scale: 1,
                          child: IconButton(
                            splashRadius: 28.0,
                            tooltip: 'Send Link',
                            onPressed: () {
                              if (linkC.text.isNotEmpty &&
                                  headingC.text.isNotEmpty) {
                                taskVm.addLink(
                                  headingC.text.toString(),
                                  linkC.text.toString(),
                                );
                                headingC.clear();
                                linkC.clear();
                              }
                            },
                            iconSize: 20,
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskVm, DashboardVm>(
      builder: (context, taskVm, dashVm, _) {
        List<Checkpoint> checkpoints = taskVm.currCheckpoints;
        List<Link> links = taskVm.currLinks;
        UserNewTask curr = taskVm.getCurr().task;
        print("taskDesc is rebuilt");
        UserTaskInstance? latest = taskVm.findLatest();
        Uri latestLink = latest!.task.psLink!;
        print("checking messageC data:${messageC.text.toString()}");
        return Scaffold(
          backgroundColor: backgroundGrey,
          extendBody: true,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.0),
              ),
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: Image.asset(
                "assets/images/back2.png",
                height: 30,
              ),
            ),
            title: const Text(
              "Task",
              style: TextStyle(
                height: 0.9,
                letterSpacing: 0.3,
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ), //TODO: ADD theme back
                  // arr[0]
                  //     ? Expanded(child: descripWidget(context))
                  //     : descripWidget(context),
                  descripWidget(context),
                  arr[1]
                      ? Flexible(child: checkPointWidget(context, checkpoints))
                      : checkPointWidget(context, checkpoints),

                  arr[2]
                      ? Expanded(child: linksWidget(context))
                      : linksWidget(context),

                  // arr[2]
                  //     ? Expanded(
                  //         child: linksWidget(context, curr.task.links, latestLink))
                  //     : linksWidget(context, curr.task.links, latestLink),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
