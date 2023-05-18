class IUser {
  String? id;
  String? name;
  String? lastname;
  String? username;
  String? email;
  String? password;

  IUser(this.id, this.name, this.lastname, this.username, this.email,
      this.password);

  IUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastname'] = lastname;
    data['username'] = username;
    data['email'] = password;
    data['password'] = password;
    return data;
  }
}
