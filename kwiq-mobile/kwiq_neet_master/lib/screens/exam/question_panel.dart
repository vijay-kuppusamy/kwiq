import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_app_model.dart';
import '../../models/question.dart';
import '../../html/flutter_html.dart';
import '../../common/common.dart';

class QuestionPanel extends StatefulWidget {
  //
  final Question question;
  final index;
  final selectedAnswer;

  QuestionPanel(this.question, this.index, this.selectedAnswer);

  @override
  _QuestionPanelState createState() {
    return _QuestionPanelState(this.question, this.index, this.selectedAnswer);
  }
}

class _QuestionPanelState extends State<QuestionPanel> {
  //
  final Question question;
  final index;
  int selectedAnswer;

  //
  _QuestionPanelState(this.question, this.index, this.selectedAnswer);

  @override
  Widget build(BuildContext context) {
    //
    double _width = MediaQuery.of(context).size.width;
    //

    return Container(
        width: _width * 0.95,
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white30,
        ),
        child: Column(
          children: <Widget>[
            getQuestion(_width, question.getQuestion()),
            Container(
              width: _width * 0.95,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70,
              ),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: selectedAnswer,
                    onChanged: (value) =>
                        _handleSelection(value, index, context),
                  ),
                  getQuestionPart(_width, question.getOptionA()),
                ],
              ),
            ),
            Container(
              width: _width * 0.95,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70,
              ),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selectedAnswer,
                    onChanged: (value) =>
                        _handleSelection(value, index, context),
                  ),
                  getQuestionPart(_width, question.getOptionB()),
                ],
              ),
            ),
            Container(
              width: _width * 0.95,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70,
              ),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: selectedAnswer,
                    onChanged: (value) =>
                        _handleSelection(value, index, context),
                  ),
                  getQuestionPart(_width, question.getOptionC()),
                ],
              ),
            ),
            Container(
              width: _width * 0.95,
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70,
              ),
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 3,
                    groupValue: selectedAnswer,
                    onChanged: (value) =>
                        _handleSelection(value, index, context),
                  ),
                  getQuestionPart(_width, question.getOptionD()),
                ],
              ),
            ),
          ],
        ));
  }

  Widget getQuestion(double _width, String text) {
    return Container(
      width: _width * 0.95,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      child: Html(
        data: getTextWithSpan(text),
        shrinkToFit: true,
      ),
      //child: Text(text, style: Theme.TextStyles.kwiqSubTitle),
    );
  }

  Widget getQuestionPart(double _width, String text) {
    return Flexible(
      child: Html(
        data: getTextWithSpan(text),
        shrinkToFit: true,
      ),
    );
    //return Text(text, style: Theme.TextStyles.kwiqContent);
  }

  getTextWithSpan(String text) {
    return Common.addHTMLTags(text);
  }

  void _handleSelection(int value, int index, BuildContext context) {
    setState(() {
      selectedAnswer = value;
    });
    //    //App State Model
    final model = Provider.of<MyAppModel>(context);
    model.updateAnswer(index, value);
  }
}
