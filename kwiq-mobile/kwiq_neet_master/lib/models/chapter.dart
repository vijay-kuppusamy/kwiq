class Chapter {
  //
  final int id;
  final String name;
  final String description;
  final String image;

  getId() => this.id;
  getName() => this.name;
  getDescription() => this.description;
  getImage() => this.image;

  Chapter({this.id, this.name, this.description, this.image});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
