import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_app_model.dart';
import '../../theme/theme.dart' as Theme;

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final model = Provider.of<MyAppModel>(context);

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    //double _height = MediaQuery.of(context).size.height;

    bool showTimer = model.getShowTimer();

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: _width * 0.95,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white54,
              border: Border(
                  //bottom: BorderSide(width: 1, color: Colors.black),
                  ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show exam timer : ",
                    style: Theme.TextStyles.kwiqItemTitle),
                Switch(
                  value: showTimer,
                  onChanged: (value) => () {
                    showTimer = value;
                  },
                  activeTrackColor: Colors.white,
                  activeColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
