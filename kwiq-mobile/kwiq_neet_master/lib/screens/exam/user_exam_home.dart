import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

import '../../theme/theme.dart' as Theme;
import '../../components/common_app_bar.dart';
import '../../models/my_app_model.dart';
import './question_card.dart';
import './time_counter.dart';
import '../../main.dart';
import '../../common/my_globals.dart';

class UserExamHome extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);
    //
    double _width = MediaQuery.of(context).size.width;

    //
    //Need to check
    //error in this place
    new CountdownTimer(new Duration(minutes: model.getExamDuration()),
            new Duration(seconds: 1))
        .listen((data) {
      if (data.remaining.inSeconds <= 0) {
        try {
          _timeElapsed(context, model);
          //_errorDialog(context, model);
        } catch (e) {
          //print(e.toString());
        }
      }
    });

    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/app-bg.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonAppBar(model.getExamName()),
          resizeToAvoidBottomInset: false,
          body: Container(
            child: ListView(
              children: <Widget>[
                buildInfoPanel(_width, model),
                QuestionCard(model.getQuestionId(), model.getIndex(),
                    model.getSelectedAnswer()),
              ],
            ),
          ),
          floatingActionButton: buildNavigationPanel(context, _width, model),
          key: myGlobals.scaffoldKey,
        )
      ],
    );
  }

  Widget buildInfoPanel(double _width, MyAppModel model) {
    int totalQuestions = model.getNoOfQues();
    int currentQuestion = model.getIndex() + 1;
    int questionsAnswered = model.getQuestionsAnswered();

    return Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white30,
        ),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0), color: Colors.white70),
          child: Row(
            children: <Widget>[
              Container(
                  width: _width * 0.65,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Total Questions : " + totalQuestions.toString(),
                        style: Theme.TextStyles.kwiqContent,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Questions Answered : " + questionsAnswered.toString(),
                        style: Theme.TextStyles.kwiqContent,
                        overflow: TextOverflow.ellipsis,
                      ),
                      TimeCounter(model.getExamDuration()),
                      Text(
                        "Current Question : " + currentQuestion.toString(),
                        style: Theme.TextStyles.kwiqContent,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  Widget buildNavigationPanel(
      BuildContext context, double _width, MyAppModel model) {
    return Container(
      width: _width * 0.90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _previousButton(model),
          _endButton(context, model),
          _nextButton(model),
        ],
      ),
    );
  }

  Widget _nextButton(MyAppModel model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => _next(model),
        tooltip: 'Next',
        child: Icon(Icons.navigate_next),
      ),
    );
  }

  Widget _previousButton(MyAppModel model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => _previous(model),
        tooltip: 'Previous',
        child: Icon(Icons.navigate_before),
      ),
    );
  }

  Widget _endButton(BuildContext context, MyAppModel model) {
    return new Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => _endDialog(context, model),
        tooltip: 'End Exam',
        child: Icon(Icons.stop),
      ),
    );
  }

  void _next(MyAppModel model) {
    //
    model.next();
  }

  void _previous(MyAppModel model) {
    //
    model.previous();
  }

  void _timeElapsed(BuildContext context, MyAppModel model) {
    Navigator.pushNamedAndRemoveUntil(
        context, EndExamRoute, (Route<dynamic> route) => false);
  }

  void _endExam(BuildContext context, MyAppModel model) {
    //
    model.updateStatus("Completed");
    Navigator.pushNamedAndRemoveUntil(
        context, ExamResultRoute, (Route<dynamic> route) => false,
        arguments: {"model": model});
  }

  Future<void> _endDialog(BuildContext context, MyAppModel model) async {
    return showDialog<void>(
      context: myGlobals.scaffoldKey.currentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End Exam ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to end the examination ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('End'),
              onPressed: () {
                Navigator.of(context).pop();
                _endExam(context, model);
              },
            ),
          ],
        );
      },
    );
  }
}
