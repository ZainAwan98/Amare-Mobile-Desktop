class User {
  final String name;
  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'],
    );
  }

  User.fromJsonProcessed(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
