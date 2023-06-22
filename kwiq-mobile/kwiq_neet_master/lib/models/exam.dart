class Exam {
  //
  final int id;
  final String name;
  final String description;
  final String image;
  final int noOfQues;
  final int markPerQue;
  final int negativeMarkPerQue;
  final int durationInMins;

  getId() => this.id;
  getName() => this.name;
  getDescription() => this.description;
  getImage() => this.image;
  getNoOfQues() => this.noOfQues;
  getMarkPerQue() => this.markPerQue;
  getNegativeMarkPerQue() => this.negativeMarkPerQue;
  getDurationInMins() => this.durationInMins;

  Exam(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.noOfQues,
      this.markPerQue,
      this.negativeMarkPerQue,
      this.durationInMins});

  factory Exam.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Exam(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        noOfQues: json['noOfQues'],
        markPerQue: json['markPerQue'],
        negativeMarkPerQue: json['negativeMarkPerQue'],
        durationInMins: json['durationInMins'],
      );
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'noOfQues': noOfQues,
        'markPerQue': markPerQue,
        'negativeMarkPerQue': negativeMarkPerQue,
        'durationInMins': durationInMins
      };
}
