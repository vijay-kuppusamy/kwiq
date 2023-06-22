import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_app_bar.dart';
import '../home/home_body.dart';
import '../course/course_body.dart';
import '../exam/exam_home.dart';
import '../settings/settings_body.dart';
import '../../common/common.dart';
import '../../models/my_app_model.dart';
import '../../components/common_navigation_bar.dart';
import '../../components/kwiq_drawer.dart';

class Home extends StatelessWidget {
  //
  final List<Widget> _bodyOptions = <Widget>[
    HomeBody(),
    CourseBody(),
    ExamHome(),
    SettingsBody()
  ];

  Widget getBody(int index) {
    if (index == null) {
      index = 0;
    }
    return _bodyOptions.elementAt(index);
  }

  //
  final List<Widget> _appBarOptions = <Widget>[
    HomeAppBar(""),
    HomeAppBar("Subjects"),
    HomeAppBar("Mock Exam"),
    HomeAppBar("Settings"),
  ];

  Widget getAppBar(int index) {
    if (index == null) {
      index = 0;
    }
    return _appBarOptions.elementAt(index);
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
          drawer: KwiqDrawer(),
          appBar: getAppBar(model.getHomePageIndex()),
          body: getBody(model.getHomePageIndex()),
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: CommonNavigationBar(),
        )
      ],
    );
  }
}
