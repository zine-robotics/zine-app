
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/tasks/repo/task_instance_repo.dart';
import 'package:zineapp2023/screens/tasks/repo/task_repo.dart';

import '../../../models/userTask.dart';

class TaskVm extends ChangeNotifier {
  final TaskRepo taskRepo;
  final TaskInstanceRepo taskInstanceRepo;
  final UserProv userProv;
  TaskVm(
      {required this.taskRepo,
      required this.taskInstanceRepo,
      required this.userProv});

  List<UserTask>? tasks = [];
  List<UserTaskInstance> taskInstances = []; //[UserTask.fromJson(json)];
  List<Checkpoint> _currCheckpoints = [];
  List<Link> _currLinks = [];

  bool _isLoading = false;
  get isLoading => _isLoading;

  bool _isError = false;
  get isError => _isError;

  bool _isCheckpointLoading = false;
  get isCheckpointLoading => _isCheckpointLoading;

  bool _isCheckpointError = false;
  get isChcekpointError => _isCheckpointError;

  bool _isLinkLoading = false;
  get isLinkLoading => _isCheckpointLoading;

  bool _isLinkError = false;
  get isLinkError => _isCheckpointError;

  List<Checkpoint> get currCheckpoints => _currCheckpoints;
  List<Link> get currLinks => _currLinks;

  int curr = 0;
  int prevLen = 0;

  // get tasks => _tasks;

  void getTaskInstances() async {
    //TODO: FAILED HOST LOOKUP
    _isLoading = true;

    try {
      taskInstances = await taskInstanceRepo.getTaskInstances();
      // print("all task instance${taskInstances.length}");
    } catch (e) {
      _isError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  void getCurrCheckpoints() async {
    _isCheckpointLoading = true;
    int instanceId = taskInstances[curr].instanceId!;
    try {
      _currCheckpoints = await taskInstanceRepo.getCheckpoints(instanceId);
      print("Final checkpointst $_currCheckpoints");
    } catch (e) {
      if (kDebugMode) print("Get Checkpoint Error");
      _isCheckpointError = true;
    }
    _isCheckpointLoading = false;
    notifyListeners();
  }
  //   print("uid from function :$uid");
  //   if (uid != null) {
  //     _tasks = await taskRepo.getTasks(uid);
  //     print("check for _tasks:$_tasks");
  //     if (_tasks!.length != prevLen) {
  //       print("notifier triggered");
  //       notifyListeners();
  //       prevLen = _tasks!.length;
  //     }
  //   }

  UserTaskInstance getCurr() {
    return taskInstances[curr];
  }

  UserTaskInstance? findLatest() {
    if (taskInstances.isNotEmpty) {
      taskInstances
          .sort((a, b) => a.task!.dateCreated!.compareTo(b.task!.dateCreated!));
      return taskInstances.first;
    }
    return null;
  }

  // UserTask? findLatest() {
  //   UserTask? ans;
  //   if (tasks!.isNotEmpty) ans = tasks![0];
  //   for (UserTask userTask in tasks!) {
  //     var one = getDMY(userTask.template!.dueDate!),
  //         two = getDMY(ans!.template!.dueDate!);
  //     if (one[2] < two[2]) {
  //       ans = userTask;
  //     } else if (one[2] == two[2]) {
  //       if (one[1] < two[1]) {
  //         ans = userTask;
  //       } else if (one[1] == two[1]) {
  //         if (one[0] < two[0]) {
  //           ans = userTask;
  //         }
  //       }
  //     }
  //   }

  //   // print("findLatest() -> latest task is: $ans");
  //   return ans;
  // }

  void getLinks() async {
    _isLinkLoading = true;

    int instanceId = taskInstances[curr].instanceId!;
    try {
      _currLinks = await taskInstanceRepo.getLinks(instanceId);
      print("Final linksdsad $_currLinks");
    } catch (e) {
      if (kDebugMode) print("Get Links Error");
      _isLinkError = true;
    }
    _isLinkLoading = false;
    notifyListeners();
  }

  void addCurrCheckpoints(String message) async {
    await taskInstanceRepo.addCheckpoints(
        message, taskInstances[curr].instanceId!);

    currCheckpoints.add(Checkpoint(
        content: message, remark: false, id: 0, timestamp: DateTime.now()));
    print("Added into curr");
    notifyListeners();
  }

  void addLink(String heading, String link) async {
    await taskInstanceRepo.addLinks(
        heading, link, taskInstances[curr].instanceId!);

    currLinks.add(Link(link, id: 0, timestamp: DateTime.now(), type: heading));
    notifyListeners();
  }
}
