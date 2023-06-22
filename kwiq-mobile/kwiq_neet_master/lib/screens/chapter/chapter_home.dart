import 'package:flutter/material.dart';

import '../chapter/chapter_body.dart';
import '../../common/common.dart';
import '../../components/common_app_bar.dart';
//import '../../components/common_navigation_bar.dart';

class ChapterHome extends StatelessWidget {
  //Subject Params
  final int subjectId;
  final String subjectName;
  ChapterHome({this.subjectId, this.subjectName});

  @override
  Widget build(BuildContext context) {
    Common.portraitModeOnly();
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
            appBar: CommonAppBar(subjectName),
            resizeToAvoidBottomInset: false,
            body: ChapterBody(subjectId, subjectName))
      ],
    );
  }
}
