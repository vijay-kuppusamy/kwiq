import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';

import '../../main.dart';
import './unit_body.dart';
import '../../theme/theme.dart' as Theme;
import '../../models/chapter.dart';
import '../../common/common.dart';
import '../../models/my_app_model.dart';
import '../../components/common_app_bar.dart';
import '../../services/course_service.dart';

class UnitData {
  int index;
  Future<String> response;
}

class UnitHome extends StatelessWidget {
  final unitData = UnitData();

  //Subject Params
  final int subjectId;
  final String subjectName;

  final int chapterId;
  final String chapterName;

  UnitHome(
      {this.subjectId, this.subjectName, this.chapterId, this.chapterName}) {
    unitData.index = 0;
    unitData.response = CourseService.fetchChapters(subjectId);
  }

  @override
  Widget build(BuildContext context) {
    Common.portraitModeOnly();
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
            appBar: CommonAppBar(chapterName),
            endDrawer: getChaptersList(context),
            resizeToAvoidBottomInset: false,
            body: UnitBody(chapterId: chapterId, chapterName: chapterName))
      ],
    );
  }

  getChaptersList(BuildContext context) {
    return FutureBuilder<String>(
      future: unitData.response,
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
              return buildDrawer(context, snapshot.data);
            }
        }
      },
    );
  }

  Drawer buildDrawer(BuildContext context, String response) {
    List<dynamic> jsonList = json.decode(response);
    List<Chapter> chapters =
        jsonList.map((e) => e == null ? null : Chapter.fromJson(e)).toList();

    List<Container> drawerOptions = [];

    for (var i = 0; i < chapters.length; i++) {
      var chapter = chapters[i];
      drawerOptions.add(Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.blue),
          ),
        ),
        child: ListTile(
          leading: new Icon(
            Icons.navigate_before,
            color: Colors.blue,
          ),
          title: Text(
            chapter.name,
            style: Theme.TextStyles.kwiqContent,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          selected: i == unitData.index,
          onTap: () => _onChapterTap(
            context,
            subjectId,
            subjectName,
            chapter.id,
            chapter.name,
          ),
        ),
      ));
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              height: 55.0,
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: DrawerHeader(
                  child: Text('Chapters',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(15.0))),
          new Column(children: drawerOptions)
        ],
      ),
    );
  }

  void _onChapterTap(
      BuildContext context, int sid, String sname, int cid, String cname) {
    Navigator.pushReplacementNamed(context, UnitHomeRoute, arguments: {
      "subjectId": sid,
      "subjectName": sname,
      "chapterId": cid,
      "chapterName": cname
    });
  }
}
