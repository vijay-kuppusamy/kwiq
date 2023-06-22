class Subject {
  //
  final int id;
  final String name;
  final String description;
  final String image;

  getId() => this.id;
  getName() => this.name;
  getDescription() => this.description;
  getImage() => this.image;

  Subject({this.id, this.name, this.description, this.image});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
