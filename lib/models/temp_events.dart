class TempEvents {
  int? id;
  String? description;
  String? type;
  String? name;
  String? venue;
  int? startDateTime;
  int? endDateTime;
  Recruitment? recruitment;

  TempEvents(
      {this.id,
        this.description,
        this.type,
        this.name,
        this.venue,
        this.startDateTime,
        this.endDateTime,
        this.recruitment});

  TempEvents.fromJson(Map<String, dynamic> json) {
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