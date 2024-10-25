/*  {
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
*/

class UserNewTask {
  String? title;
  int? id;
  String? description;

  DateTime? dateCreated;
  DateTime? dueDate;
  Uri? psLink;
  Uri? submissionLink;
  bool? isRecruitment;
  bool? isVisible;
  String? subtitle;

  UserNewTask({
    required this.title,
    required this.id,
    this.description,
    this.dateCreated,
    this.dueDate,
    this.isRecruitment,
    this.isVisible,
    this.psLink,
    this.submissionLink,
    this.subtitle,
  });

  UserNewTask.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "jsonNull";
    id = json['id'] ?? "jsonNull";
    subtitle = json['subtitle'] ?? 'jsonNull';
    dateCreated = DateTime.fromMillisecondsSinceEpoch(json['createdDate'] ?? 0);
    dueDate = DateTime.fromMillisecondsSinceEpoch(json['dueDate'] ?? 0);
    psLink = Uri.tryParse(json['psLink'] ?? 'http://www.google.com');
    submissionLink =
        Uri.tryParse(json['submissionLink'] ?? 'http://www.google.com');
    description = json['description'] ?? "jsonNull";
    isVisible = json['visible'] ?? "jsonNull";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = title;
    data['id'] = id;
    data['description'] = description;
    return data;
  }

  // UserNewTask.store(snapshot)
  //     : title = snapshot.data()['title'],
  //       id = snapshot.data()['id'],
  //       description = snapshot.data()['description'];
}
