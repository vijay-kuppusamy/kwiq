import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../models/my_app_model.dart';
import '../../models/chapter.dart';
import '../../services/course_service.dart';

class ChapterResponse {
  Future<String> value;
}

class ChapterBody extends StatelessWidget {
  //
  final chapterResponse = ChapterResponse();

  //Subject Params
  final int subjectId;
  final String subjectName;

  ChapterBody(this.subjectId, this.subjectName) {
    chapterResponse.value = CourseService.fetchChapters(subjectId);
  }

  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);

    return Container(
      child: getChaptersList(context, model),
    );
  }

  getChaptersList(BuildContext context, MyAppModel model) {
    return FutureBuilder<String>(
      future: chapterResponse.value,
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
              return buildChaptersList(context, snapshot.data, model);
            }
        }
      },
    );
  }

  buildChaptersList(BuildContext context, String data, MyAppModel model) {
    List<dynamic> jsonList = json.decode(data);
    List<Chapter> chapters =
        jsonList.map((e) => e == null ? null : Chapter.fromJson(e)).toList();

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: chapters.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: buildChapterItem(
              context,
              _width,
              _height,
              subjectId,
              subjectName,
              chapters[index].id,
              chapters[index].name,
              chapters[index].description),
        );
      },
      //separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildChapterItem(BuildContext context, double _width, double _height,
      int sid, String sname, int cid, String cname, String cdescription) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color(0x8034b0fc),
        onTap: () {},
        child: GestureDetector(
          onTap: () => _onChapterTap(
            context,
            sid,
            sname,
            cid,
            cname,
          ),
          child: Container(
            height: _height * 0.10,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.Colors.white70,
            ),
            child: Center(
                //child: Text("Course", style: optionStyle),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(3.0),
                  width: _width * 0.10,
                  child: Image.asset(
                    'assets/images/chapter1.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(5.0),
                    width: _width * 0.70,
                    child: Text(
                      cname,
                      style: Theme.TextStyles.kwiqSubTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
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
