import 'package:flutter/material.dart';
import './common_widgets.dart';
import '../theme/theme.dart' as Theme;

class HomeCard extends StatelessWidget {
  //
  final String _title;
  final String _body;
  final String _icon;

  HomeCard(this._title, this._body, this._icon);

  @override
  Widget build(BuildContext context) {
    //Screen width and height
    //double _height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      //height: _height * 0.30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(1.0),
                  margin: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    _icon,
                    height: Theme.Dimens.kwiqCardHeight,
                    width: Theme.Dimens.kwiqCardHeight,
                    fit: BoxFit.scaleDown,
                  )),
              Container(
                  padding: const EdgeInsets.all(1.0),
                  margin: const EdgeInsets.all(1.0),
                  child: Text(_title, style: Theme.TextStyles.kwiqCardTitle)),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.Colors.white70,
                boxShadow: CommonWidgets.getBoxShadow(),
              ),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(5.0),
              child: Text(_body,
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                  style: Theme.TextStyles.kwiqContent,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
