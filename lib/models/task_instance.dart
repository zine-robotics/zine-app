/*{
            "taskInstanceId": 52,
            "taskId": {
                "id": 152,
                "createdDate": 1715491800000,
                "title": "update-task-name-second",
                "subtitle": "test-task-subtile",
                "description": "test-task-description",
                "dueDate": 1715491800000,
                "psLink": null,
                "submissionLink": null,
                "type": "Individual",
                "recruitment": null,
                "visible": false
            },
            "roomId": {
                "id": 652,
                "name": "task instance",
                "description": null,
                "type": "project",
                "dpUrl": null,
                "timestamp": null
            },
            "type": "individual",
            "name": null,
            "status": null,
            "completionPercentage": null
        },
*/

import 'package:zineapp2023/models/newTask.dart';

class UserTaskInstance {
  String? title;
  int? instanceId;
  UserNewTask task;
  int? roomId;
  String? roomName;
  String? status;
  int? completionPercentage;

  UserTaskInstance(
      {required this.title,
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
    roomName=json['roomName'];
    status=json['status'];
    completionPercentage=json['completionPercentage'];
  }
}

enum InstanceType { group, individual }

class Checkpoint {
  late int id;
  late String content;
  late bool remark;
  late DateTime timestamp;

  Checkpoint(
      {required this.id,
      required this.content,
      required this.remark,
      required this.timestamp});

  Checkpoint.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    remark = json['remark'] ?? false;
    content = json['content'] ?? '';
    timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp'] ?? 0);
  }
}

class Link {
  late int id;
  late String type;
  late DateTime timestamp;
  late Uri link;

  Link(
    String link, {
    required this.id,
    required this.timestamp,
    required this.type,
  }) {
    this.link = Uri.tryParse(link) ?? Uri.parse('https://zine.co.in');
  }

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    type = json['type'] ?? 'Link';
    link = Uri.tryParse(json['link']) ?? Uri.parse('https://zine.co.in');
    timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp'] ?? 0);
  }
}
