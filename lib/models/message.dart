class MessageModel {
  int? id;
  MessageType type;
  String? text;
  FileData? file;
  PollData? poll;
  SentFrom? sentFrom;
  DateTime? timestamp;
  ReplyTo? replyTo;

  MessageModel({
    required this.type,
    required this.timestamp,
    required this.id,
    this.sentFrom,
    this.poll,
    this.replyTo,
    this.text,
    this.file,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : type = MessageType.values.byName(json['type'] ?? 'text'),
        replyTo = json['replyTo'],
        sentFrom = SentFrom.fromJson(json['sentFrom']) {
    switch (type) {
      case MessageType.file:
        file = FileData.fromJson(json['file']);
        break;

      case MessageType.poll:
        poll = PollData.fromJson(json['poll']);
        break;

      case MessageType.text:
        text = json['text']['content'];
    }
    id = json['id'];

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
    data['text'] = {'content': text};
    data['file'] = file?.toJson();
    data['poll'] = poll?.toJson();
    data['timestamp'] = timestamp;

    data['sentFrom'] = sentFrom?.toJson();
    data['replyTo'] = replyTo?.toJson();
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
  int id;
  String? name;
  String? description;
  String? type;
  String? dpUrl;
  int? timestamp;

  RoomId({
    required this.id,
    this.name,
    this.description,
    this.type,
    this.dpUrl,
    this.timestamp,
  });

  RoomId.fromJson(Map<String, dynamic> json) : id = json['id'] {
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
  MessageType type;
  String? text;
  String? fileName;
  String? pollName;
  SentFrom? sentFrom;
  DateTime? timestamp;
  ReplyTo? replyTo;
  RoomId roomId;

  ReplyTo({
    required this.type,
    required this.timestamp,
    required this.id,
    required this.roomId,
    this.sentFrom,
    this.replyTo,
    this.text,
    this.pollName,
    this.fileName,
  });

  ReplyTo.fromJson(Map<String, dynamic> json)
      : type = MessageType.values.byName(json['type'] ?? 'text'),
        replyTo = json['replyTo'],
        sentFrom = json['sentFrom'],
        roomId = RoomId.fromJson(json['roomId']) {
    id = json['id'];
    pollName = json['pollName'];
    fileName = json['fileName'];
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
    data['text'] = {'content': text};
    data['file'] = fileName.toString();
    data['poll'] = pollName.toString();
    data['timestamp'] = timestamp;

    data['sentFrom'] = sentFrom?.toJson();
    data['replyTo'] = replyTo?.toJson();
    return data;
  }
}

enum MessageType { file, text, poll }

class FileData {
  Uri uri;
  String description;
  String name;

  FileData({required this.uri, required this.description, required this.name});

  FileData.fromJson(Map<String, dynamic> json)
      : uri = Uri.parse(json['url'] ??
            'https://zine.co.in/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fzine1.eacd1990.png&w=1920&q=75'),
        description = json['description'] ?? '',
        name = json['name'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'url': uri.toString(), // Convert the Uri back to a string
      'description': description,
      'name': name,
    };
  }
}

class PollData {
  String title;
  String description;
  List<PollOption> pollOptions;
  int? lastVoted;

  PollData(
      {required this.title,
      required this.description,
      required this.pollOptions,
      this.lastVoted});

  PollData.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        description = json['description'],
        pollOptions = (json['options'] as List)
            .map((e) => PollOption.fromJson(e))
            .toList(),
        lastVoted = json['lastVoted'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'pollOptions': pollOptions,
      'lastVoted': lastVoted,
    };
  }
}

class PollOption {
  int id;
  String value;
  int numVotes;

  // Constructor
  PollOption({
    required this.id,
    required this.value,
    required this.numVotes,
  });

  PollOption.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        value = json['value'] ?? '',
        numVotes = json['numVotes'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'numVotes': numVotes,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'PollOption: id: $id, value: $value, numVotes: $numVotes';
  }
}
