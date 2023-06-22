import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

import '../../theme/theme.dart' as Theme;
import '../../common/common.dart';

class TimeCounter extends StatefulWidget {
  //
  final int examDuration;
  TimeCounter(this.examDuration);
  //
  @override
  _TimeCounterState createState() {
    return _TimeCounterState(examDuration);
  }
}

class _TimeCounterState extends State<TimeCounter> {
  int examDuration = 0;
  int remainingTime = 0;
  //
  @override
  void initState() {
    super.initState();
  }

  _TimeCounterState(this.examDuration) {
    setUpTimer();
  }

  setUpTimer() {
    CountdownTimer(Duration(minutes: examDuration), Duration(seconds: 1))
        .listen((data) {
      if (!mounted) {
        return;
      }
      setState(() {
        remainingTime = data.remaining.inSeconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Text(
          "Time Remaining (mins) : " + Common.getTimerValue(remainingTime),
          style: Theme.TextStyles.kwiqContent),
    );
  }
}
