class User {
  String documentId;
  String name;
  int age;
  DateTime dateCreated;

  User({
    required this.documentId,
    required this.name,
    required this.age,
    required this.dateCreated,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      documentId: json['documentId'],
      name: json['name'],
      age: json['age'],
      dateCreated: DateTime.parse(json['dateCreated']),
    );
  }
}
