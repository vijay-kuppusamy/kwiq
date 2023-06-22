import 'package:flutter/material.dart';
import 'package:kwiq_neet_master/main.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:convert';

import '../../theme/theme.dart' as Theme;
import '../../models/unit.dart';
import '../../models/my_app_model.dart';
import '../../services/course_service.dart';

class UnitBody extends StatefulWidget {
  final int chapterId;
  final String chapterName;

  UnitBody({Key key, this.chapterId, this.chapterName}) : super(key: key);

  @override
  _UnitBodyState createState() {
    return _UnitBodyState(chapterId, chapterName);
  }
}

class _UnitBodyState extends State<UnitBody> {
  final int chapterId;
  final String chapterName;

  _UnitBodyState(this.chapterId, this.chapterName);

  Future<String> value;
  List<Unit> units;

  @override
  void initState() {
    super.initState();
    value = CourseService.fetchUnits(chapterId);
  }

  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);

    return Container(
      child: getUnitsList(context, model),
    );
  }

  getUnitsList(BuildContext context, MyAppModel model) {
    return FutureBuilder<String>(
      future: value,
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
              return buildUnitsList(context, snapshot.data, model);
            }
        }
      },
    );
  }

  buildUnitsList(BuildContext context, String data, MyAppModel model) {
    //
    List<dynamic> jsonList = json.decode(data);
    units = jsonList.map((e) => e == null ? null : Unit.fromJson(e)).toList();

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: units.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.Colors.white70,
          ),
          child: buildUnitItem(context, _width, _height, units[index].id,
              units[index].name, units[index].videoUrl),
        );
      },
      //separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildUnitItem(BuildContext context, double _width, double _height,
      int id, String name, String videoUrl) {
    return Column(
      children: <Widget>[
        Container(
          width: _width * 90,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            name,
            style: Theme.TextStyles.kwiqItemTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: () => _onVideoTap(context, id, name, videoUrl),
          child: Container(
            width: _width * 70,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: Colors.blue),
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _width * 0.10,
                  child: Icon(Icons.play_circle_filled, color: Colors.blue),
                ),
                Text(
                  "Watch video",
                  style: Theme.TextStyles.kwiqSubTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _onReadTap(context, id, name),
          child: Container(
            width: _width * 70,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: _width * 0.10,
                  child: Icon(Icons.local_library, color: Colors.blue),
                ),
                Text(
                  "Read lesson",
                  style: Theme.TextStyles.kwiqSubTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _onVideoTap(BuildContext context, int id, String name, String videoUrl) {
    if (videoUrl != null) {
      Navigator.pushNamed(context, VideoHomeRoute,
          arguments: {"unitId": id, "unitName": name, "videoUrl": videoUrl});
    }
  }

  _onReadTap(BuildContext context, int id, String name) {
    Navigator.pushNamed(context, ContentHomeRoute,
        arguments: {"unitId": id, "unitName": name});
  }
}
