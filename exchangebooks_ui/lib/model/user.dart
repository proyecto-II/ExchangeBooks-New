class IUser {
  String? id;
  String? name;
  String? lastname;
  String? username;
  String? email;
  String? password;
  String? googleId;

  IUser(this.id, this.name, this.lastname, this.username, this.email,
      this.password, this.googleId);

  IUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    googleId = json['googleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastname'] = lastname;
    data['username'] = username;
    data['email'] = password;
    data['password'] = password;
    data['googleId'] = googleId;
    return data;
  }
}
