import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/message_response_model.dart';

class MessageUpdateResponseModel {
  String update;
  MessageResponseModel? body;
  PollUpdate? pollUpdate;
  String? errorMessage;

  MessageUpdateResponseModel(
      this.update, this.body, this.pollUpdate, this.errorMessage);

  MessageUpdateResponseModel.fromJson(Map<String, dynamic> json)
      : update = json['update'],
        body = json['body'] != null
            ? MessageResponseModel.fromJson(json['body'])
            : null,
        pollUpdate = json['pollUpdate'] != null
            ? PollUpdate.fromJson(json['pollUpdate'])
            : null,
        errorMessage = json['errorMessage'];
}

class PollUpdate {
  int chatItemId;
  List<PollOption> pollOptions;

  PollUpdate(this.chatItemId, this.pollOptions);

  PollUpdate.fromJson(Map<String, dynamic> json)
      : chatItemId = json['chatItemId'] ?? -1,
        pollOptions = (json['pollOptions'] as List)
            .map((e) => PollOption.fromJson(e))
            .toList();
}

extension MessageUpdateResponseModelMapper on MessageUpdateResponseModel {
  MessageModel toModel() {
    return body!.toModel();
  }
}
