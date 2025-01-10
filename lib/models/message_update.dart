import 'package:zineapp2023/models/message.dart';

class MessageUpdate {
  String update;
  MessageModel body;

  MessageUpdate(this.update, this.body);

  MessageUpdate.fromJson(Map<String, dynamic> json)
      : update = json['update'],
        body = MessageModel.fromJson(json['body']);
}

class PollUpdate {
  int chatItemId;
  List<Map<String, dynamic>> updateData;

  PollUpdate.fromJson(Map<String, dynamic> json)
      : chatItemId = json['chatItemId'] ?? -1,
        updateData = json['PollVoteBody'] ?? {};
}
