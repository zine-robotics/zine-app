class Events {
  int? id;
  String? description;
  String? type;
  String? name;
  String? venue;
  DateTime? startDateTime;
  DateTime? endDateTime;
  Recruitment? recruitment;

  Events(
      {this.id,
        this.description,
        this.type,
        this.name,
        this.venue,
        this.startDateTime,
        this.endDateTime,
        this.recruitment});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    type = json['type'];
    name = json['name'];
    venue = json['venue'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    recruitment = json['recruitment'] != null
        ? new Recruitment.fromJson(json['recruitment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['type'] = this.type;
    data['name'] = this.name;
    data['venue'] = this.venue;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    if (this.recruitment != null) {
      data['recruitment'] = this.recruitment!.toJson();
    }
    return data;
  }
}

List<Events> dummyEvents = [
  Events(
    id: 1,
    description: "An annual tech expo featuring the latest in AI and robotics.",
    type: "Technology",
    name: "Tech Innovators 2024",
    venue: "Silicon Valley Convention Center",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1709164800), // Mar 31, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1709251200), // Apr 1, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 2,
    description: "A music festival showcasing local and international talent.",
    type: "Music",
    name: "Harmony Fest",
    venue: "Downtown Park",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1707619200), // Mar 12, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1707705600), // Mar 13, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 3,
    description: "An art exhibit featuring works from contemporary artists.",
    type: "Art",
    name: "Modern Expressions",
    venue: "City Art Gallery",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1708992000), // Mar 29, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1709078400), // Mar 30, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 4,
    description: "A charity marathon supporting local community programs.",
    type: "Sports",
    name: "Run for Hope",
    venue: "Central Stadium",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1708233600), // Mar 23, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1708248000), // Mar 23, 2024, 4:00 AM
    recruitment: null,
  ),
  Events(
    id: 5,
    description: "A workshop on effective leadership and team management.",
    type: "Workshop",
    name: "Leadership Bootcamp",
    venue: "Hilton Conference Hall",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1708473600), // Mar 26, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1708556400), // Mar 26, 2024, 9:00 PM
    recruitment: null,
  ),
  Events(
    id: 6,
    description: "A two-day coding competition for developers of all levels.",
    type: "Competition",
    name: "Code Sprint 2024",
    venue: "TechHub Arena",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1707177600), // Mar 7, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1707350400), // Mar 9, 2024, 12:00 AM (spans two days)
    recruitment: null,
  ),
  Events(
    id: 7,
    description: "A seminar on sustainable practices for businesses.",
    type: "Environment",
    name: "Green Business Summit",
    venue: "Eco Center",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1707705600), // Mar 13, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1707792000), // Mar 14, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 8,
    description: "A networking event for entrepreneurs and investors.",
    type: "Business",
    name: "Startup Connect",
    venue: "Innovation Hub",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1707446400), // Mar 10, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1707532800), // Mar 11, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 9,
    description:
        "A cultural festival celebrating global cuisines and traditions.",
    type: "Culture",
    name: "World Fiesta",
    venue: "Heritage Plaza",
    startDateTime: DateTime.fromMillisecondsSinceEpoch( 1708723200), // Mar 28, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1708809600), // Mar 29, 2024, 12:00 AM
    recruitment: null,
  ),
  Events(
    id: 10,
    description: "A book fair with author signings and discussion panels.",
    type: "Education",
    name: "Readers' Haven",
    venue: "National Library",
    startDateTime: DateTime.now().add(Duration(days: 2)), // Mar 20, 2024, 12:00 AM
    endDateTime: DateTime.fromMillisecondsSinceEpoch(1708041600), // Mar 21, 2024, 12:00 AM
    recruitment: null,
  ),
];

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
