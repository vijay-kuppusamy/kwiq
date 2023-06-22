import 'package:flutter/material.dart';

import '../../components/home_card.dart';
import '../../common/common.dart';

class NeetIntroduction extends StatelessWidget {
  //
  final String _title = "About NEET";
  final String _body = Common.getAboutNEETIntro();
  final String _icon = "assets/images/about-neet.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeCard(this._title, this._body, this._icon),
    );
  }
}
