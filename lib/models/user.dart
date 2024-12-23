import 'package:zineapp2023/models/userTask.dart';

class UserModel {
  String? email;
  int? id;
  String? uid;
  String? type = 'user';
  String? name;
  bool? registered = false;
  String? pushToken;
  List<UserTask>? tasks = [];
  List<dynamic>? rooms = [];
  List<dynamic>? roomids = [];
  dynamic roomDetails = {};
  dynamic lastSeen;
  String? dp;

  UserModel(
      {this.uid,
      this.id,
      this.email,
      this.name,
      this.type,
      this.dp,
      this.tasks,
      this.registered,
      this.pushToken,
      this.lastSeen,
      this.rooms,
      this.roomids,
      this.roomDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    uid = json['uid'];
    name = json['name'];
    type = json['type'];
    tasks = json['tasks'];
    dp = json['dp'];
    registered = json['registered'];
    pushToken = json['pushToken'];
    rooms = json['rooms'];
    roomids = json['roomids'];
    lastSeen = json['lastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['type'] = type;
    data['tasks'] = tasks;
    data['dp'] = dp;
    data['registered'] = registered;
    data['pushToken'] = pushToken;
    data['rooms'] = rooms;
    data['roomids'] = roomids;
    data['lastSeen'] = lastSeen;
    return data;
  }
}
class ActiveMember {
  String? name;
  String? email;
  String? role;
  String? dpUrl;

  ActiveMember({this.name, this.email, this.role, this.dpUrl});

  ActiveMember.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    dpUrl = json['dpUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['dpUrl'] = this.dpUrl;
    return data;
  }
}
