import 'package:flutter/material.dart';
import 'package:kwiq_neet_master/common/common.dart';
import 'dart:convert';
import '../../models/my_app_model.dart';
import '../../models/user_exam.dart';
import '../../services/test_service.dart';
import '../../components/common_app_bar.dart';
import '../../theme/theme.dart' as Theme;
import '../../main.dart';

class ResultData {
  Future<String> value;
}

class ExamResult extends StatelessWidget {
  final resultData = ResultData();
  //
  ExamResult({MyAppModel model}) {
    resultData.value = TestService.saveExam(model);
  }

  @override
  Widget build(BuildContext context) {
    //
    // todo: clear user exam in model state
    //
    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/app-bg.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar("Exam Result"),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: getExamResult(context),
        ),
      ),
    ]);
  }

  getExamResult(BuildContext context) {
    return FutureBuilder<String>(
      future: resultData.value,
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
              return buildExamResult(snapshot.data, context);
            }
        }
      },
    );
  }

  buildExamResult(String data, BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    final jsonResponse = json.decode(data);

    UserExam userExam = UserExam.fromJsonSlim(jsonResponse);

    String startTime = Common.getDateTimeStr(userExam.getStartTime());
    String endTime = Common.getDateTimeStr(userExam.getEndTime());

    return Container(
      child: Column(
        children: <Widget>[
          new SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _width * 0.40,
                              child: Text("Start Time",
                                  style: Theme.TextStyles.kwiqContent),
                            ),
                            Text(" : " + startTime,
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _width * 0.40,
                              child: Text("End Time",
                                  style: Theme.TextStyles.kwiqContent),
                            ),
                            Text(" : " + endTime,
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _width * 0.40,
                              child: Text("Questions Answered",
                                  style: Theme.TextStyles.kwiqContent),
                            ),
                            Text(
                                " : " +
                                    userExam
                                        ?.getQuestionsAnsweredPre()
                                        ?.toString(),
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _width * 0.40,
                              child: Text("Correct Answers",
                                  style: Theme.TextStyles.kwiqContent),
                            ),
                            Text(
                                " : " +
                                    userExam?.getCorrectAnsweres()?.toString(),
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: _width * 0.40,
                              child: Text("Wrong Answers",
                                  style: Theme.TextStyles.kwiqContent),
                            ),
                            Text(
                                " : " + userExam?.getWrongAnswers()?.toString(),
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black45),
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: _width * 0.40,
                                child: Text("Score",
                                    style: Theme.TextStyles.kwiqContent)),
                            Text(" : " + userExam?.getScore()?.toString(),
                                style: Theme.TextStyles.kwiqContent),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () => _goToHome(context),
                child: Text(
                  "Go To Home",
                  textAlign: TextAlign.center,
                  style: Theme.TextStyles.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeRoute);
  }
}
