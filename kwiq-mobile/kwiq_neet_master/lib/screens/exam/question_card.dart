import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../models/question.dart';
import '../../models/my_app_model.dart';
import '../../services/test_service.dart';
import './question_panel.dart';

class CardData {
  Future<String> value;
}

class QuestionCard extends StatelessWidget {
  //
  final questionId;
  final index;
  final selectedAnswer;
  //
  final CardData cardData = CardData();
  //
  QuestionCard(this.questionId, this.index, this.selectedAnswer) {
    cardData.value = TestService.fetchQuestion(this.questionId);
  }

  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);
    //
    double _width = MediaQuery.of(context).size.width;
    //
    return getQuestionPanel(model, _width);
  }

  Widget getQuestionPanel(MyAppModel model, double _width) {
    return FutureBuilder<String>(
      future: cardData.value,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return buildQuestionPanel(model, _width, snapshot.data);
            }
        }
      },
    );
  }

  Widget buildQuestionPanel(MyAppModel model, double _width, String data) {
    final jsonResponse = json.decode(data);
    Question question = Question.fromJson(jsonResponse);
    //
    return QuestionPanel(question, index, selectedAnswer);
  }
}
