import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../components/common_app_bar.dart';
import '../../services/test_service.dart';
import '../../models/my_app_model.dart';
import '../../models/user_exam.dart';
import '../../models/exam.dart';
import '../../models/navigation.dart';

class UserExamResponse {
  Future<String> value;
}

class StartExam extends StatelessWidget {
  //Exam Params
  final int userId;
  final int examId;
  final String examName;
  //
  final res = UserExamResponse();
  //
  StartExam({this.userId, this.examId, this.examName}) {
    Map data = {"userId": userId, "examId": examId};
    res.value = TestService.createExam(data);
  }

  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);

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
          appBar: CommonAppBar(examName),
          resizeToAvoidBottomInset: false,
          body: Container(child: getUserExamDetail(context, model)),
        )
      ],
    );
  }

  getUserExamDetail(BuildContext context, MyAppModel model) {
    //
    return FutureBuilder<String>(
      future: res.value,
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
              return buildUserExamDetail(context, snapshot.data, model);
            }
        }
      },
    );
  }

  buildUserExamDetail(BuildContext context, String data, MyAppModel model) {
    //
    final jsonResponse = json.decode(data);
    UserExam userExam = UserExam.fromJson(jsonResponse);
    //
    final Exam exam = userExam?.getExam();
    final String name = exam?.getName() ?? "";
    final int noOfQues = exam?.getNoOfQues() ?? 0;
    final int markPerQue = exam?.getMarkPerQue() ?? 0;
    final int negativeMarkPerQue = exam?.getNegativeMarkPerQue() ?? 0;
    final int durationInMins = exam?.getDurationInMins() ?? 0;
    //
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(20.0),
          //color: Colors.white30,
          ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Exam Name : ", style: Theme.TextStyles.kwiqContent),
                    Text(name, style: Theme.TextStyles.kwiqContent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("No of questions : ",
                        style: Theme.TextStyles.kwiqContent),
                    Text("$noOfQues", style: Theme.TextStyles.kwiqContent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Marks per Question : ",
                        style: Theme.TextStyles.kwiqContent),
                    Text("$markPerQue", style: Theme.TextStyles.kwiqContent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Negative mark per Question : ",
                        style: Theme.TextStyles.kwiqContent),
                    Text("$negativeMarkPerQue",
                        style: Theme.TextStyles.kwiqContent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Duration In Mins : ",
                        style: Theme.TextStyles.kwiqContent),
                    Text("$durationInMins",
                        style: Theme.TextStyles.kwiqContent),
                  ],
                ),
              ],
            ),
          ),
          new SizedBox(
            height: 20.0,
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Color(0xff01A0C7),
            child: MaterialButton(
              //minWidth: double.infinity,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () => _startExam(context, model, userExam),
              child: Text(
                "Start Exam",
                textAlign: TextAlign.center,
                style: Theme.TextStyles.button,
              ),
            ),
          ),
          new SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  void _startExam(BuildContext context, MyAppModel model, UserExam userExam) {
    //

    userExam.updateStartTime();
    userExam.updateEndTime();
    userExam.updateStatus("In Progress");
    model.setUserExam(userExam);
    //
    Navigation navigation = Navigation();
    int index = navigation.getIndex();
    int questionId = userExam.getQuestionId(index);
    navigation.setQuestionId(questionId);
    //
    model.setNavigation(navigation);
    //
    Navigator.pushNamedAndRemoveUntil(
        context, UserExamHomeRoute, (Route<dynamic> route) => false);
  }
}
