class Rooms {
  int? id;
  String? name;
  String? description;
  String? type;
  String dpUrl;
  int? timestamp;
  int? lastMessageTimestamp;
  int? unreadMessages;
  int? userLastSeen;

  Rooms({
    this.id,
    this.name,
    this.description,
    this.type,
    this.dpUrl = '',
    this.timestamp,
    this.lastMessageTimestamp,
    this.unreadMessages,
    this.userLastSeen,
  });

  Rooms.fromJson(Map<String, dynamic> json)
      : id = json['room']['id'],
        name = json['room']['name'],
        description = json['room']['description'],
        type = json['room']['type'],
        dpUrl = json['room']['dpUrl'] ?? '',
        timestamp = json['room']['timestamp'],
        lastMessageTimestamp = json['lastMessageTimestamp'],
        unreadMessages = json['unreadMessages'],
        userLastSeen = json['userLastSeen'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['room'] = {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'dpUrl': dpUrl,
      'timestamp': timestamp,
    };

    data['lastMessageTimestamp'] = lastMessageTimestamp;
    data['unreadMessages'] = unreadMessages;
    data['userLastSeen'] = userLastSeen;

    return data;
  }

  // If storing from Firestore snapshot
  Rooms.store(snapshot)
      : id = snapshot.data()['id'],
        name = snapshot.data()['name'],
        description = snapshot.data()['description'],
        type = snapshot.data()['type'],
        dpUrl = snapshot.data()['dpUrl'],
        timestamp = snapshot.data()['timestamp'],
        lastMessageTimestamp = snapshot.data()['lastMessageTimestamp'],
        unreadMessages = snapshot.data()['unreadMessages'],
        userLastSeen = snapshot.data()['userLastSeen'];
}
