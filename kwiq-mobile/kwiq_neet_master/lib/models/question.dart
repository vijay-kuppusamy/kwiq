class Question {
  //
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  getQuestion() => this.question;
  getOptionA() => this.optionA;
  getOptionB() => this.optionB;
  getOptionC() => this.optionC;
  getOptionD() => this.optionD;

  Question(
      {this.question, this.optionA, this.optionB, this.optionC, this.optionD});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
    );
  }
}
