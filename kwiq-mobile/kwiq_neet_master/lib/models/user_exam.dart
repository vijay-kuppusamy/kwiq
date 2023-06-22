import './exam.dart';
import './exam_question.dart';
import '../common/common.dart';

class UserExam {
  int id;
  int userId;
  DateTime startTime;
  DateTime endTime;
  int questionsAnswered;
  int correctAnswers;
  int wrongAnswers;
  String status;
  int score;

  Exam exam;
  List<ExamQuestion> examQuestions;

  getId() => this.id;
  getUserId() => this.userId;
  getStartTime() => this.startTime ?? "";
  getEndTime() => this.endTime ?? "";
  getQuestionsAnsweredPre() => this.questionsAnswered;
  getCorrectAnsweres() => this.correctAnswers;
  getWrongAnswers() => this.wrongAnswers;
  getStatus() => this.status;
  getScore() => this.score;
  getExam() => this.exam;
  getExamQuestions() => this.examQuestions;

  //
  getQuestionId(int index) {
    int id = 0;
    if (this.examQuestions != null && index <= examQuestions.length) {
      return examQuestions[index].getQuestionId();
    }
    return id;
  }

  updateStartTime() {
    this.startTime = Common.getCurrentDateTime();
  }

  getExamDuration() {
    if (this.exam != null) {
      return this.exam.getDurationInMins();
    }
    return 0;
  }

  updateEndTime() {
    this.endTime =
        Common.addMinutesToDateTime(this.getStartTime(), getExamDuration());
  }

  getRemainingTime() {
    if (endTime != null) {
      return endTime.difference(Common.getCurrentDateTime()).inSeconds;
    }
  }

  updateStatus(String status) {
    this.status = status;
  }

  updateAnswer(int index, int answer) {
    if (this.examQuestions != null && index <= examQuestions.length) {
      examQuestions[index].setUserAnswer(answer?.toString());
    }
  }

  getSelectedAnswer(int index) {
    String selectedAnswer;
    if (this.examQuestions != null && index <= examQuestions.length) {
      selectedAnswer = examQuestions[index].getUserAnswer();
    }
    if (selectedAnswer != null && selectedAnswer != "") {
      return int.parse(selectedAnswer);
    } else {
      return -1;
    }
  }

  getQuestionsAnswered() {
    int count = 0;
    if (this.examQuestions != null && examQuestions.length > 0) {
      for (var i = 0; i < examQuestions.length; i++) {
        if (examQuestions[i].getUserAnswer() != null &&
            examQuestions[i].getUserAnswer() != "") {
          count++;
        }
      }
    }
    return count;
  }

  UserExam(
      {this.id,
      this.userId,
      this.startTime,
      this.endTime,
      this.status,
      this.questionsAnswered,
      this.correctAnswers,
      this.wrongAnswers,
      this.score,
      this.exam,
      this.examQuestions});

  factory UserExam.fromJson(Map<String, dynamic> json) {
    var examFromJson = json['exam'];
    Exam _exam = Exam.fromJson(examFromJson);

    List<dynamic> examQuestionsFromJson = json['examquestions'];
    List<ExamQuestion> _examQuestions;

    if (examQuestionsFromJson != null) {
      _examQuestions = examQuestionsFromJson
          .map((e) => e == null ? null : ExamQuestion.fromJson(e))
          .toList();
    }

    return UserExam(
        id: json['id'],
        userId: json['userId'],
        status: json['status'],
        questionsAnswered: json['questionsAnswered'],
        correctAnswers: json['correctAnswers'],
        wrongAnswers: json['wrongAnswers'],
        startTime: Common.getDateTime(json['startTime']),
        endTime: Common.getDateTime(json['endTime']),
        score: json['score'],
        exam: _exam,
        examQuestions: _examQuestions);
  }

  factory UserExam.fromJsonSlim(Map<String, dynamic> json) {
    return UserExam(
        id: json['id'],
        userId: json['userId'],
        status: json['status'],
        questionsAnswered: json['questionsAnswered'],
        correctAnswers: json['correctAnswers'],
        wrongAnswers: json['wrongAnswers'],
        startTime: Common.getDateTime(json['startTime']),
        endTime: Common.getDateTime(json['endTime']),
        score: json['score']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'status': status,
        'questionsAnswered': questionsAnswered,
        'correctAnswers': correctAnswers,
        'wrongAnswers': wrongAnswers,
        'startTime': Common.getDateTimeStr(startTime),
        'endTime': Common.getDateTimeStr(endTime),
        'score': score,
        'exam': getExamJson(),
        'examquestions': getExamQuesionsJson()
      };

  getExamJson() {
    if (exam != null) {
      //return json.encode(exam.toJson());
      return exam.toJson();
    }
    return {};
  }

  getExamQuesionsJson() {
    var questions = [];
    if (examQuestions != null && examQuestions.length > 0) {
      for (var item in examQuestions) {
        //questions.add(json.encode(item.toJson()));
        questions.add(item.toJson());
      }
      return questions;
    }
    return [];
  }
}
