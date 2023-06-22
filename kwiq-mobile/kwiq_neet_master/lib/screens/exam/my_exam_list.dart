import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../../components/common_app_bar.dart';
import '../../theme/theme.dart' as Theme;
import '../../common/common.dart';
import '../../models/user_exam.dart';
import '../../services/test_service.dart';

class ExamResponse {
  Future<String> value;
}

class MyExamList extends StatelessWidget {
  //
  final userId;
  final examResponse = ExamResponse();
  //
  MyExamList({this.userId}) {
    if (userId != null) {
      examResponse.value = TestService.fetchMyExams(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: CommonAppBar("My Exams"),
          resizeToAvoidBottomInset: false,
          body: Container(
            child: getExamsList(context),
          ),
        )
      ],
    );
  }

  getExamsList(BuildContext context) {
    return FutureBuilder<String>(
      future: examResponse.value,
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
              return buildExamList(context, snapshot.data);
            }
        }
      },
    );
  }

  buildExamList(BuildContext context, String data) {
    //converting json string to Subject model
    double _height = MediaQuery.of(context).size.height;

    List<dynamic> jsonList = json.decode(data);
    List<UserExam> userExams =
        jsonList.map((e) => e == null ? null : UserExam.fromJson(e)).toList();

    return ListView.builder(
      itemCount: userExams.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(child: buildExamItem(context, userExams[index]));
      },
    );
  }

  Widget buildExamItem(BuildContext context, UserExam userExam) {
    //Screen width and height
    double _width = MediaQuery.of(context).size.width;

    String startTime = Common.getDateStr(userExam.getStartTime());

    return (Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white70),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: _width * 0.40,
                        child:
                            Text("Date", style: Theme.TextStyles.kwiqContent),
                      ),
                      Text(" : " + startTime,
                          style: Theme.TextStyles.kwiqContent),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: _width * 0.40,
                        child: Text("Questions Answered",
                            style: Theme.TextStyles.kwiqContent),
                      ),
                      Text(
                          " : " +
                              userExam?.getQuestionsAnsweredPre()?.toString(),
                          style: Theme.TextStyles.kwiqContent),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: _width * 0.40,
                        child: Text("Correct Answers",
                            style: Theme.TextStyles.kwiqContent),
                      ),
                      Text(" : " + userExam?.getCorrectAnsweres()?.toString(),
                          style: Theme.TextStyles.kwiqContent),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: _width * 0.40,
                        child: Text("Wrong Answers",
                            style: Theme.TextStyles.kwiqContent),
                      ),
                      Text(" : " + userExam?.getWrongAnswers()?.toString(),
                          style: Theme.TextStyles.kwiqContent),
                    ],
                  ),
                ),
                Container(
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
    ));
  }
// End
}
