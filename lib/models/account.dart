class Account {
  String? name;
  String? email;
  String? password;

  Account({this.name, this.email, this.password});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      email: json['email'], name: json['name'], password: json['password']);

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "password": password};
}
