import 'package:flutter/material.dart';

import '../../components/home_card.dart';
import '../../common/common.dart';

class AboutKwiq extends StatelessWidget {
  //
  final String _title = "Kwiq Academy";
  final String _body = Common.getAboutKwiqIntro();
  final String _icon = "assets/images/about-kwiq.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeCard(this._title, this._body, this._icon),
    );
  }
}
