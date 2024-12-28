class NewUserModel {
  int? id;
  String? name;
  String? email;
  String? type;
  String? pushToken;
  bool? registered;
  String? dp;
  String? imagePath;
  bool? emailVerified;

  NewUserModel(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.pushToken,
        this.registered,
        this.dp,
        this.imagePath,
        this.emailVerified});

  NewUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    pushToken = json['pushToken'];
    registered = json['registered'];
    dp = json['dp'];
    imagePath = json['imagePath'];
    emailVerified = json['emailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['pushToken'] = this.pushToken;
    data['registered'] = this.registered;
    data['dp'] = this.dp;
    data['imagePath'] = this.imagePath;
    data['emailVerified'] = this.emailVerified;
    return data;
  }
}