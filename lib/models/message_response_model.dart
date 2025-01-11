import 'package:flutter/material.dart';

import 'message.dart';

//This model is used for API message mapping
class MessageResponseModel {
  int? id;
  MessageType type;
  TextData? text;
  FileData? file;
  PollData? poll;
  SentFrom? sentFrom;
  DateTime? timestamp;
  ReplyTo? replyTo;
  late bool deleted;

  MessageResponseModel(
      {required this.type,
      required this.timestamp,
      required this.id,
      required this.sentFrom,
      this.poll,
      this.replyTo,
      this.text,
      this.file,
      this.deleted = false});

  MessageResponseModel.fromJson(Map<String, dynamic> json)
      : type = MessageType.values.byName(json['type'] ?? 'text'),
        replyTo =
            json['replyTo'] != null ? ReplyTo.fromJson(json['replyTo']) : null,
        sentFrom = SentFrom.fromJson(json['sentFrom']) {
    switch (type) {
      case MessageType.file:
        file = FileData.fromJson(json['file']);
        break;

      case MessageType.poll:
        poll = PollData.fromJson(json['poll']);
        break;

      case MessageType.text:
        text = TextData.fromJson(json['text']);
    }
    id = json['id'];
    deleted = json['deleted'];

    if (json['timestamp'] == null) timestamp = DateTime.now();

    if (json['timestamp'] is int) {
      timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
    } else if (json['timestamp'] is String) {
      timestamp = DateTime.parse(json['timestamp']);
    } else {
      timestamp = DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type.toString();
    data['text'] = text?.toJson();
    data['file'] = file?.toJson();
    data['poll'] = poll?.toJson();
    data['timestamp'] = timestamp;
    data['sentFrom'] = sentFrom?.toJson();
    data['replyTo'] = replyTo?.toJson();
    data['deleted'] = deleted;
    return data;
  }
}

//Stores Sent From Data
class SentFrom {
  int? id;
  late String name;
  late String dp;

  SentFrom({this.id, this.name = 'Anonymous', this.dp = ""});

  SentFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? 'Anonymous';
    dp = json['dp'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dp'] = dp;
    return data;
  }
}

class ReplyTo {
  int? id;

  ReplyTo({
    required this.id,
  });

  ReplyTo.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

extension MessageRequestModelMapper on MessageResponseModel {
  MessageModel toModel() {
    return MessageModel(
      id: id,
      type: type,
      timestamp: timestamp,
      sender: Sender.fromJson(sentFrom!.toJson()),
      poll: poll,
      replyToId: replyTo?.id, // Assuming `ReplyTo` has an `id` field
      text: text,
      file: file,
    );
  }
}
