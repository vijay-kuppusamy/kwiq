class ExamQuestion {
  int id;
  int questionId;
  String userAnswer;
  String answer;

  getId() => this.id;
  getQuestionId() => this.questionId;
  getUserAnswer() => this.userAnswer;
  getAnswer() => this.answer;

  setUserAnswer(String answer) => this.userAnswer = answer;

  ExamQuestion({this.id, this.questionId, this.userAnswer, this.answer});

  factory ExamQuestion.fromJson(Map<String, dynamic> json) {
    return ExamQuestion(
      id: json['id'],
      questionId: json['questionId'],
      userAnswer: json['userAnswer'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': questionId,
        'userAnswer': userAnswer,
        'answer': answer
      };
}
