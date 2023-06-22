import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../common/common.dart';
import '../../models/my_app_model.dart';
import '../../models/exam.dart';
import '../../models/user.dart';
import '../../services/test_service.dart';

class ExamResponse {
  Future<String> value;
}

class ExamList extends StatelessWidget {
  //
  final examResponse = ExamResponse();
  //
  ExamList() {
    examResponse.value = TestService.fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    Common.portraitModeOnly();
    //App State Model
    final model = Provider.of<MyAppModel>(context);

    return getExamsList(context, model);
  }

  getExamsList(BuildContext context, MyAppModel model) {
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
              return buildExamList(context, snapshot.data, model);
            }
        }
      },
    );
  }

  buildExamList(BuildContext context, String data, MyAppModel model) {
    //converting json string to Subject model
    List<dynamic> jsonList = json.decode(data);
    List<Exam> exams =
        jsonList.map((e) => e == null ? null : Exam.fromJson(e)).toList();

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: exams.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: buildExamItem(context, _width, _height, exams[index].id,
              exams[index].name, exams[index].description, exams[index].image),
        );
      },
    );
  }

  Widget buildExamItem(BuildContext context, double _width, double _height,
      int id, String title, String description, String image) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color(0x8034b0fc),
        onTap: () {},
        child: GestureDetector(
          onTap: () => _onExamTap(context, id, title),
          child: Container(
            height: _height * 0.15,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.Colors.white70,
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: _width * 0.10,
                  child: Image.asset(
                    'assets/images/test-icon.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: _width * 0.60,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.all(5.0),
                          child: Text(
                            title,
                            style: Theme.TextStyles.kwiqItemTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.all(2.0),
                          child: Text(
                            description,
                            style: Theme.TextStyles.kwiqContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: _width * 0.10,
                  child: Icon(Icons.play_arrow, color: Colors.blue),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  _onExamTap(BuildContext context, int id, String name) {
    final model = Provider.of<MyAppModel>(context);
    final User user = model.getUser();
    if (user != null) {
      Navigator.pushNamed(context, StartExamRoute,
          arguments: {"userId": user.getId(), "examId": id, "examName": name});
    } else {
      Navigator.pushNamed(context, LoginRoute);
    }
  }
//End
}
