class MessageModel {
  int? id;
  String? type;
  String? content;
  String? contentUrl;
  int? timestamp;
  SentFrom? sentFrom;
  dynamic roomId;
  dynamic replyTo;

  MessageModel({
    this.id,
    this.type,
    this.content,
    this.contentUrl,
    this.timestamp,
    this.sentFrom,
    this.roomId,
    this.replyTo,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    contentUrl = json['contentUrl'];

    if (json['timestamp'] is int) {
      timestamp = json['timestamp'];
    } else if (json['timestamp'] is String) {
      timestamp = DateTime.parse(json['timestamp']).millisecondsSinceEpoch;
    } else {
      timestamp = null;
    }

    sentFrom =
        json['sentFrom'] != null ? SentFrom.fromJson(json['sentFrom']) : null;
    roomId = json['roomId'] != null ? RoomId.fromJson(json['roomId']) : null;
    replyTo =
        json['replyTo'] != null ? ReplyTo.fromJson(json['replyTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['content'] = content;
    data['contentUrl'] = contentUrl;
    data['timestamp'] = timestamp;

    if (sentFrom != null) {
      data['sentFrom'] = sentFrom!.toJson();
    }
    if (roomId != null) {
      data['roomId'] = roomId!.toJson();
    }
    if (replyTo != null) {
      data['replyTo'] = replyTo!.toJson();
    }
    return data;
  }
}

//TODO: LOOK INTO THIS
class SentFrom {
  int? id;
  late String name;
  String? email;
  String? type;
  String? pushToken;
  bool? registered;
  late String dp;
  bool? emailVerified;

  SentFrom({
    this.id,
    this.name = 'Anonymous',
    this.email,
    this.type,
    this.pushToken,
    this.registered,
    this.dp = '',
    this.emailVerified,
  });

  SentFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? 'Anonymous';
    email = json['email'];
    type = json['type'];
    pushToken = json['pushToken'];
    registered = json['registered'];
    dp = json['dp'] ?? ''; //TODO:: THIS SHOUld PROBABLY BE dpUrl !!!!
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['type'] = type;
    data['pushToken'] = pushToken;
    data['registered'] = registered;
    data['dp'] = dp;
    data['emailVerified'] = emailVerified;
    return data;
  }
}

class RoomId {
  int? id;
  String? name;
  String? description;
  String? type;
  String? dpUrl;
  int? timestamp;

  RoomId({
    this.id,
    this.name,
    this.description,
    this.type,
    this.dpUrl,
    this.timestamp,
  });

  RoomId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    dpUrl = json['dpUrl'];
    // timestamp = json['timestamp'];
    if (json['timestamp'] is int) {
      timestamp = json['timestamp'];
    } else if (json['timestamp'] is String) {
      timestamp = DateTime.parse(json['timestamp']).millisecondsSinceEpoch;
    } else {
      timestamp = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['dpUrl'] = dpUrl;
    data['timestamp'] = timestamp;
    return data;
  }
}

// Helper method to handle parsing integers
int? _parseInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value);
  }
  return null;
}

// Helper method to handle parsing timestamps
int? _parseTimestamp(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    try {
      return DateTime.parse(value).millisecondsSinceEpoch;
    } catch (_) {
      return null;
    }
  }
  return null;
}

class ReplyTo {
  int? id;
  String? type;
  String? content;
  String? contentUrl;
  int? timestamp;
  SentFrom? sentFrom;
  RoomId? roomId;
  ReplyTo? replyTo;

  ReplyTo({
    this.id,
    this.type,
    this.content,
    this.contentUrl,
    this.timestamp,
    this.sentFrom,
    this.roomId,
    this.replyTo,
  });

  ReplyTo.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    type = json['type'];
    content = json['content'];
    contentUrl = json['contentUrl'];
    // timestamp =  _parseTimestamp(json['timestamp']) ;
    if (json['timestamp'] is int) {
      timestamp = json['timestamp'];
    } else if (json['timestamp'] is String) {
      timestamp = DateTime.parse(json['timestamp']).millisecondsSinceEpoch;
    } else {
      timestamp = null;
    }

    sentFrom =
        json['sentFrom'] != null ? SentFrom.fromJson(json['sentFrom']) : null;
    roomId = json['roomId'] != null ? RoomId.fromJson(json['roomId']) : null;
    replyTo =
        json['replyTo'] != null ? ReplyTo.fromJson(json['replyTo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['content'] = content;
    data['contentUrl'] = contentUrl;
    data['timestamp'] = timestamp;

    if (sentFrom != null) {
      data['sentFrom'] = sentFrom!.toJson();
    }
    if (roomId != null) {
      data['roomId'] = roomId!.toJson();
    }
    if (replyTo != null) {
      data['replyTo'] = replyTo!.toJson();
    }
    return data;
  }
}
