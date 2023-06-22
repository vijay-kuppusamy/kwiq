class User {
  final int id;
  final String name;
  final String email;
  final String token;

  getId() => this.id;
  getName() => this.name;
  getEmail() => this.email;
  getToken() => this.token;

  User(this.id, this.name, this.email, this.token);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        token = json['token'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'token': token};
}
