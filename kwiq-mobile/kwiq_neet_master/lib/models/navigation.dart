class Navigation {
  int index = 0;
  int questionId = 0;
  int _selectedAnswer = -1;

  getIndex() => this.index;
  setIndex(int index) => this.index = index;

  getQuestionId() => this.questionId;
  setQuestionId(int questionId) => this.questionId = questionId;

  getSelectedAnswer() => _selectedAnswer;
  setSelectedAnswer(int selected) => this._selectedAnswer = selected;

  //
}
