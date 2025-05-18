import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:zineapp2023/models/task_instance.dart';
import 'package:zineapp2023/models/userTask.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/tasks/repo/task_instance_repo.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';


final logger = customLogger();

class TaskVm extends ChangeNotifier {
  final TaskInstanceRepo taskInstanceRepo;
  final UserProv userProv;
  TaskVm(
      {
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

  // ignore: unused_field
  bool _isLinkLoading = false;
  get isLinkLoading => _isCheckpointLoading;

  // ignore: unused_field
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
      logger.i('Task instances fetched successfully');
    } catch (e) {
      logger.e(e);
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
      logger.i('Checkpoints fetched successfully');
    } catch (e) {
      _isCheckpointError = true;
      logger.e(e);
    }
    _isCheckpointLoading = false;
    notifyListeners();
  }

  UserTaskInstance getCurr() {
    return taskInstances[curr];
  }

  UserTaskInstance? findLatest() {
    if (taskInstances.isNotEmpty) {
      taskInstances
          .sort((a, b) => a.task.dateCreated!.compareTo(b.task.dateCreated!));
      return taskInstances.first;
    }
    return null;
  }

  void getLinks() async {
    _isLinkLoading = true;

    int instanceId = taskInstances[curr].instanceId!;
    try {
      _currLinks = await taskInstanceRepo.getLinks(instanceId);
      logger.i('Links fetched successfully');
    } catch (e) {
      _isLinkError = true;
      logger.e(e);
    }
    _isLinkLoading = false;
    notifyListeners();
  }

  void addCurrCheckpoints(String message) async {
    await taskInstanceRepo.addCheckpoints(
        message, taskInstances[curr].instanceId!);

    currCheckpoints.add(Checkpoint(
        sentFrom: userProv.getUserInfo.name,
        sentFromId: userProv.getUserInfo.id,
        content: message,
        remark: userProv.getUserInfo.type == 'admin', //TODO: change to admin
        id: 0,
        timestamp: DateTime.now()));
    logger.i('Checkpoint added successfully');
    notifyListeners();
  }

  void addLink(String heading, String link) async {
    await taskInstanceRepo.addLinks(
        heading, link, taskInstances[curr].instanceId!);

    currLinks.add(Link(link,
        id: 0,
        timestamp: DateTime.now(),
        type: heading,
        sentFrom: userProv.getUserInfo.name,
        sentFromId: userProv.getUserInfo.id));
    logger.i('Link added successfully');
    notifyListeners();
  }
}
