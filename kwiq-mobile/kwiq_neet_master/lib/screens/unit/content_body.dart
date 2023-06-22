import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../../html/flutter_html.dart';
import '../../services/course_service.dart';
import '../../models/unit.dart';
import '../../common/common.dart';

class Data {
  Future<String> value;
}

class ContentBody extends StatelessWidget {
  //
  final data = Data();

  //Subject Params
  final int unitId;

  ContentBody(this.unitId) {
    data.value = CourseService.fetchUnit(unitId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.all(5.0),
        child: getContent(context),
      ),
    );
  }

  getContent(BuildContext context) {
    return FutureBuilder<String>(
      future: data.value,
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
              return buildChaptersList(context, snapshot.data);
            }
        }
      },
    );
  }

  buildChaptersList(BuildContext context, String data) {
    //
    Unit unit = Unit.fromJson(json.decode(data));
    return Container(
      child: Html(
          data: getTextWithSpan(unit.getContent()),
          padding: EdgeInsets.all(8.0),
          backgroundColor: Colors.white70,
          defaultTextStyle: TextStyle(fontFamily: 'serif'),
          useRichText: true),
    );
  }

  getTextWithSpan(String text) {
    return Common.addHTMLTags(text);
  }
}
