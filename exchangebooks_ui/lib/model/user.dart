class User {
  String? id;
  String? name;
  String? lastname;
  String? nickname;
  String? email;
  String? password;

  User(this.id, this.name, this.lastname, this.nickname, this.email,
      this.password);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastname = json['lastname'];
    nickname = json['nickname'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastname'] = lastname;
    data['nickname'] = nickname;
    data['email'] = password;
    data['password'] = password;
    return data;
  }
}
