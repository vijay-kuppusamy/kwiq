import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../common/common.dart';
import '../../models/my_app_model.dart';
import '../../models/subject.dart';
import '../../services/course_service.dart';

class SubjectResponse {
  Future<String> value;
}

class SubjectBody extends StatelessWidget {
  //
  final subjectResponse = SubjectResponse();

  SubjectBody(loadData) {
    if (loadData) {
      subjectResponse.value = CourseService.fetchSubjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    Common.portraitModeOnly();
    //App State Model
    final model = Provider.of<MyAppModel>(context);

    return Container(
      child: Center(
        child: getSubjectsList(context, model),
      ),
    );
  }

  getSubjectsList(BuildContext context, MyAppModel model) {
    if (model.getSubjects() != null) {
      return buildSubjectList(context, model.getSubjects(), model);
    } else {
      return FutureBuilder<String>(
        future: subjectResponse.value,
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
                return buildSubjectList(context, snapshot.data, model);
              }
          }
        },
      );
    }
  }

  buildSubjectList(BuildContext context, String data, MyAppModel model) {
    //Updating state
    if (model.getSubjects() == null) {
      model.setSubjects(data);
    }
    //converting json string to Subject model
    List<dynamic> jsonList = json.decode(data);
    List<Subject> subjects =
        jsonList.map((e) => e == null ? null : Subject.fromJson(e)).toList();

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: buildSubjectItem(
              context,
              _width,
              _height,
              subjects[index].id,
              subjects[index].name,
              subjects[index].description,
              subjects[index].image),
        );
      },
    );
  }

  Widget buildSubjectItem(BuildContext context, double _width, double _height,
      int id, String title, String description, String image) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color(0x8034b0fc),
        onTap: () {},
        child: GestureDetector(
          onTap: () => _onSubjectTap(context, id, title),
          child: Container(
            height: _height * 0.20,
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
                  width: _width * 0.15,
                  child: Image.asset(
                    'assets/images/' + image,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: _width * 0.50,
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
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Container(
                  width: _width * 0.15,
                  child: Icon(Icons.play_arrow, color: Colors.blue),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  _onSubjectTap(BuildContext context, int id, String name) {
    Navigator.pushNamed(context, ChapterHomeRoute,
        arguments: {"subjectId": id, "subjectName": name});
  }
//End
}
