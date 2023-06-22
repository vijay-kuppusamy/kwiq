import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../components/common_app_bar.dart';
import './content_body.dart';

class ContentData {
  int index;
}

class ContentHome extends StatelessWidget {
  final data = ContentData();

  final int unitId;
  final String unitName;

  ContentHome({this.unitId, this.unitName});

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
            appBar: CommonAppBar(unitName),
            resizeToAvoidBottomInset: false,
            body: ContentBody(unitId))
      ],
    );
  }
}
