import 'package:flutter/material.dart';

import '../../common/common.dart';
import '../../components/common_app_bar.dart';
import './video_body.dart';

class VideoHome extends StatelessWidget {
  //
  final int unitId;
  final String unitName;
  final String videoUrl;

  VideoHome({this.unitId, this.unitName, this.videoUrl});

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
            body: VideoBody(name: unitName, videoUrl: videoUrl))
      ],
    );
  }
}
