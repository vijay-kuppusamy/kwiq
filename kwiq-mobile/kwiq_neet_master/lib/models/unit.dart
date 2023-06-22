class Unit {
  //Unit variables
  final int id;
  final String name;
  final String videoUrl;
  final String content;
  bool isExpanded;

  getId() => this.id;
  getName() => this.name;
  getVideoUrl() => this.videoUrl;
  getContent() => this.content;
  getIsExpanded() => this.isExpanded;

  setIsExpanded(bool isExpanded) => this.isExpanded = isExpanded;

  Unit(
      {this.id,
      this.name,
      this.videoUrl,
      this.content,
      this.isExpanded = false});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
      videoUrl: json['videoUrl'],
      content: json['content'],
    );
  }
}
