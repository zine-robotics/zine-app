import 'package:zineapp2023/models/newTask.dart';

class UserTaskInstance {
  String? title;
  int? instanceId;
  UserNewTask task;
  int? roomId;
  String? roomName;
  String? status;
  int? completionPercentage;

  UserTaskInstance({
    required this.title,
    required this.instanceId,
    required this.task,
    this.roomId,
    this.roomName,
    this.completionPercentage,
    this.status,
  });

  UserTaskInstance.fromJson(Map<String, dynamic> json)
      : task = UserNewTask.fromJson(json['task']) {
    roomId = json['roomId']['id'];
    instanceId = json['id'];
    title = json['name'];
    roomName = json['roomName'];
    status = json['status'];
    completionPercentage = json['completionPercentage'];
  }
}

enum InstanceType { group, individual }

class Checkpoint {
  late int id;
  late String content;
  String? sentFrom;
  int? sentFromId;
  late bool remark;
  late DateTime timestamp;

  Checkpoint(
      {required this.id,
      required this.content,
      required this.remark,
      required this.timestamp,
      this.sentFrom,
      this.sentFromId});

  Checkpoint.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    remark = json['remark'] ?? false;
    content = json['content'] ?? '';
    timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp'] ?? 0);
    sentFrom = json['sentFrom'] ?? '';
    sentFromId = json['sentFromId'] ?? 0;
  }
}

class Link {
  late int id;
  late String type;
  late DateTime timestamp;
  late Uri link;
  String? sentFrom;
  int? sentFromId;

  Link(
    String link, {
    required this.id,
    required this.timestamp,
    required this.type,
    this.sentFrom,
    this.sentFromId,
  }) {
    this.link = Uri.tryParse(link) ?? Uri.parse('https://zine.co.in');
  }

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? 'Link';
    link = Uri.tryParse(json['link']) ?? Uri.parse('https://zine.co.in');
    timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp'] ?? 0);
    sentFrom = json['sentFrom'] ?? '';
    sentFromId = json['sentFromId'] ?? 0;
  }
}
