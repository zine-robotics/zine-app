class Events {
  int? id;
  String? description;
  String? type;
  String? name;
  String? venue;
  DateTime? startDateTime;
  DateTime? endDateTime;
  Recruitment? recruitment;
  String? eventDp;
  Events(
      {this.id,
      this.description,
      this.type,
      this.name,
      this.venue,
      this.startDateTime,
      this.endDateTime,
      this.recruitment,
      this.eventDp});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    name = json['name'];
    venue = json['venue'];
    if (json['startDateTime'] != null) {
      startDateTime = DateTime.tryParse(json['startDateTime'].toString()) ?? DateTime.fromMillisecondsSinceEpoch(json['startDateTime']);
    }
    if (json['endDateTime'] != null) {
      endDateTime = DateTime.tryParse(json['endDateTime'].toString()) ?? DateTime.fromMillisecondsSinceEpoch(json['endDateTime']);
    }
    // startDateTime = json['startDateTime'];
    // endDateTime = json['endDateTime'];
    recruitment = json['recruitment'] != null
        ? new Recruitment.fromJson(json['recruitment'])
        : null;
    eventDp=json['dpUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['type'] = this.type;
    data['name'] = this.name;
    data['venue'] = this.venue;
    if (startDateTime != null) {
      data['startDateTime'] = startDateTime?.toIso8601String(); // Convert DateTime to ISO 8601 string
    }
    if (endDateTime != null) {
      data['endDateTime'] = endDateTime?.toIso8601String(); // Convert DateTime to ISO 8601 string
    }
    // data['startDateTime'] = this.startDateTime;
    // data['endDateTime'] = this.endDateTime;
    if (this.recruitment != null) {
      data['recruitment'] = this.recruitment!.toJson();
    }
    return data;
  }
}

class Recruitment {
  int? id;
  String? title;
  int? stage;
  String? description;

  Recruitment({this.id, this.title, this.stage, this.description});

  Recruitment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    stage = json['stage'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['stage'] = this.stage;
    data['description'] = this.description;
    return data;
  }
}

//----------------------------------------lastSeen Api--------------------------------------//
class LastSeen {
  int? lastMessageTimestamp;
  int? unreadMessages;
  int? userLastSeen;

  LastSeen({this.lastMessageTimestamp, this.unreadMessages, this.userLastSeen});

  LastSeen.fromJson(Map<String, dynamic> json) {
    lastMessageTimestamp = json['lastMessageTimestamp'];
    unreadMessages = json['unreadMessages'];
    userLastSeen = json['userLastSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastMessageTimestamp'] = this.lastMessageTimestamp;
    data['unreadMessages'] = this.unreadMessages;
    data['userLastSeen'] = this.userLastSeen;
    return data;
  }
}
