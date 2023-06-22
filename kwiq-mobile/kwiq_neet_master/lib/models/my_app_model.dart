import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/user.dart';
import '../models/user_exam.dart';
import '../models/navigation.dart';

class MyAppModel extends ChangeNotifier {
// My App Model Begin

  int _homePageIndex = 0;
  getHomePageIndex() => this._homePageIndex;
  setHomePageIndex(int index) {
    _homePageIndex = index;
    notifyListeners();
  }

  bool _showTimer = true;
  getShowTimer() => this._showTimer;
  setShowTimer(bool showTimer) {
    _showTimer = showTimer;
    notifyListeners();
  }

  User _user;
  getUser() => _user;
  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  String _subjects;
  getSubjects() => _subjects;
  setSubjects(String subjects) {
    _subjects = subjects;
    //notifyListeners();
  }

  int _subjectId;
  getSubjectId() => this._subjectId;
  setSubjectId(int id) {
    _subjectId = id;
    //notifyListeners();
  }

  String _chapters;
  getChapters() => _chapters;
  setChapters(String chapters) {
    _chapters = chapters;
    //notifyListeners();
  }

  int _chapterId;
  getChapterId() => _chapterId;
  setChaptersId(int chapterId) {
    _chapterId = chapterId;
    //notifyListeners();
  }

  String _units;
  getUnits() => _units;
  setUnits(String units) {
    _units = units;
    //notifyListeners();
  }

  int _unitId;
  getUnitId() => _unitId;
  setUnitId(int unitId) {
    _unitId = unitId;
    //notifyListeners();
  }

  String _exams;
  getExams() => _exams;
  setExams(String exams) {
    _exams = exams;
    //notifyListeners();
  }

  UserExam _userExam;
  getUserExam() => _userExam;
  setUserExam(UserExam userExam) {
    _userExam = userExam;
    notifyListeners();
  }

  Navigation _navigation;
  getNavigation() => _navigation;
  setNavigation(Navigation navigation) {
    _navigation = navigation;
    notifyListeners();
  }

  //
  getExamName() {
    if (_userExam != null && _userExam.getExam() != null) {
      return _userExam.getExam().getName();
    }
    return " ";
  }

  //
  getNoOfQues() {
    if (_userExam != null && _userExam.getExam() != null) {
      return _userExam.getExam().getNoOfQues();
    }
    return 0;
  }

  //
  getExamDuration() {
    if (_userExam != null && _userExam.getExam() != null) {
      return _userExam.getExam().getDurationInMins();
    }
    return 0;
  }

  //
  getQuestionsAnswered() {
    if (_userExam != null) {
      return _userExam.getQuestionsAnswered();
    }
    return 0;
  }

  //
  getRemainingTime() {
    if (_userExam != null) {
      return _userExam.getRemainingTime();
    }
    return 0;
  }

  //
  getIndex() {
    if (_navigation != null) {
      return _navigation.getIndex();
    }
    return 0;
  }

  //
  getSelectedAnswer() {
    if (_navigation != null) {
      return _navigation.getSelectedAnswer();
    }
    return 0;
  }

  //
  getQuestionId() {
    if (_navigation != null) {
      return _navigation.getQuestionId();
    }
    return 0;
  }

  updateAnswer(int index, int answer) {
    if (_userExam != null) {
      _userExam.updateAnswer(index, answer);
    }
  }

  updateStatus(String status) {
    if (_userExam != null) {
      _userExam.updateStatus(status);
    }
  }

  getUserExamJson() {
    if (_userExam != null) {
      return json.encode(_userExam.toJson());
    }
  }

  //
  next() {
    if (_navigation != null && _userExam != null) {
      Navigation navigation = getNavigation();
      int index = _navigation.getIndex();
      int total = getNoOfQues();
      if (index + 1 < total) {
        index = index + 1;
        navigation.setIndex(index);
        navigation.setSelectedAnswer(_userExam.getSelectedAnswer(index));
        navigation.setQuestionId(_userExam.getQuestionId(index));
        setNavigation(navigation);
      }
    }
  }

  previous() {
    if (_navigation != null && _userExam != null) {
      Navigation navigation = getNavigation();
      int index = _navigation.getIndex();
      if (index - 1 >= 0) {
        index = index - 1;
        navigation.setIndex(index);
        navigation.setSelectedAnswer(_userExam.getSelectedAnswer(index));
        navigation.setQuestionId(_userExam.getQuestionId(index));
        setNavigation(navigation);
      }
    }
  }

// My App Model End
}
