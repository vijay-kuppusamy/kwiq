import 'package:flutter/material.dart';

import '../../main.dart';
import '../home/home_slider.dart';
import '../home/neet_introduction.dart';
import '../home/about_kwiq.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
            //height: _height * 0.30,
            color: Colors.transparent,
            child: HomeSlider()),
        Container(
            //height: _height * 0.25,
            child: GestureDetector(
          child: NeetIntroduction(),
          onTap: () => _onCardTap(context, "About NEET"),
        )),
        Container(
            //height: _height * 0.25,
            child: GestureDetector(
          child: AboutKwiq(),
          onTap: () => _onCardTap(context, "About Kwiq"),
        )),
      ],
    ));
  }

  _onCardTap(BuildContext context, String name) {
    Navigator.pushNamed(context, ArticleScreenRoute, arguments: {"name": name});
  }
}
