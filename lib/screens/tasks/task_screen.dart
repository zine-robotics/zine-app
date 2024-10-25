import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';

import 'package:zineapp2023/screens/tasks/taskCard.dart';
import 'package:zineapp2023/screens/tasks/taskDesc.dart';
import 'package:zineapp2023/screens/tasks/view_models/task_vm.dart';
import 'package:zineapp2023/common/routing.dart';
import 'dart:math' as math;
import '../home/home_screen.dart';
import 'recent_task.dart';
import '../../theme/color.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}
String _selectedFilter = "All Task";
class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var tasksVM = Provider.of<TaskVm>(context, listen: false);
      tasksVM.getTaskInstances();
    });
  }

  List<UserTaskInstance> _filterTasks(List<UserTaskInstance> tasks) {
    if (_selectedFilter == "All Task") {
      return tasks;
    }
    List<UserTaskInstance> filter=tasks.where((instance) => instance.status == _selectedFilter).toList();
    print("filter task instance name:${filter.length}");
    return tasks.where((instance) => instance.status == _selectedFilter).toList();
  }
  @override
  void dispose() {
    _selectedFilter = 'All Task';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProv, TaskVm>(builder: (context, userProv, taskVm, _) {
      if (taskVm.isLoading)
        return Center(
          child: CircularProgressIndicator(),
        );
      // List<UserTask>? tasks = userProv.getUserInfo.tasks;

      // taskVm.taskInstances = tasks;

      List<UserTaskInstance> tasks = taskVm.taskInstances;
      List<UserTaskInstance> filteredTasks = _filterTasks(tasks);

      if (taskVm.isError) tasks = [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Recent Tasks",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xff8D989F),
              fontSize: 18.0,
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  tasks.length == 0
                      ? SizedBox(
                          height: 220.0,
                          child: Transform.rotate(
                            angle: math.pi / 90,
                            child: const Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              color: Color(0x69D9D9D9),
                              elevation: 0,
                              child: Center(
                                child: Text(""),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 220.0,
                          child: Transform.rotate(
                            angle: math.pi / 80,
                            child: const Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              color: Color(0x66268CCB),
                              elevation: 0,
                              child: Center(
                                child: Text("Hi"),
                              ),
                            ),
                          ),
                        ),
                  tasks.length == 0
                      ? const Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          color: iconTile,
                          elevation: 0,
                          child: SizedBox(
                            height: 220.0,
                            child: Center(
                              child: Text(
                                //"No tasks to show ${taskVm.tasks?.length}  ",

                                "No tasks to show",

                                style: TextStyle(
                                    color: backgroundGrey,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 220,
                          child: RecentTask(),
                        ),
                ],
              ),
            ),
          ),
          DefaultTabController(
            length: 1,
            initialIndex: 0,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                   TabBar(
                      padding: EdgeInsets.all(8.0),
                      indicatorWeight: 0.1,
                      labelColor: blurBlue,
                      labelStyle: TextStyle(
                          fontSize: 14.5, fontWeight: FontWeight.w800),
                      unselectedLabelColor: greyText,
                      unselectedLabelStyle: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center, // Center the text
                                child: Text("$_selectedFilter"),
                              ),
                              Align(
                                alignment: Alignment.centerRight, // Align the button to the right
                                child: PopupMenuButton<String>(
                                  onSelected: (String value) {
                                    setState(() {
                                    _selectedFilter = value;
                                    });

                                    print(value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem<String>(
                                        value: 'All Task',
                                        child: Text('All Task'),
                                      ),PopupMenuItem<String>(
                                        value: 'Assigned',
                                        child: Text('Assigned'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Not Started',
                                        child: Text('Not Started'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'in-review',
                                        child: Text('in-review'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Completed',
                                        child: Text('Completed'),
                                      ),
                                    ];
                                  },
                                  child: Icon(Icons.sort, size: 24.0), // Dropdown button icon
                                ),
                              ),
                            ],
                          ),
                        )


                        // Text("All Task"),
                        // Text("Review"),
                        // Text("In Progress"),
                        // Text("Completed"),
                      ]),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              if (tasks.isEmpty)
                                 Column(
                                  children: [
                                    SizedBox(
                                      height: 130.0,
                                    ),
                                    Text(
                                      "No Tasks Assigned",
                                      style: TextStyle(
                                          color: iconTile,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              for (int i = 0; i < filteredTasks.length; i++)
                                TaskCard(
                                  curr: filteredTasks[i],
                                  index: i,
                                ),
                            ],
                          ),
                        ),
                        // const Column(
                        //   children: [
                        //     SizedBox(
                        //       height: 130.0,
                        //     ),
                        //     Text(
                        //       "No Tasks Assigned",
                        //       style: TextStyle(
                        //           color: iconTile,
                        //           fontSize: 30.0,
                        //           fontWeight: FontWeight.w700),
                        //     ),
                        //   ],
                        // ),
                        // const Column(
                        //   children: [
                        //     SizedBox(
                        //       height: 130.0,
                        //     ),
                        //     Text(
                        //       "No Tasks Assigned",
                        //       style: TextStyle(
                        //           color: iconTile,
                        //           fontSize: 30.0,
                        //           fontWeight: FontWeight.w700),
                        //     ),
                        //   ],
                        // ),
                        // const Column(
                        //   children: [
                        //     SizedBox(
                        //       height: 130.0,
                        //     ),
                        //     Text(
                        //       "No Tasks Assigned",
                        //       style: TextStyle(
                        //           color: iconTile,
                        //           fontSize: 30.0,
                        //           fontWeight: FontWeight.w700),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
