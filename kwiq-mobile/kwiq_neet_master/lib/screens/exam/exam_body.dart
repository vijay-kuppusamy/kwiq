import 'package:flutter/material.dart';

import '../../common/common.dart';
import './exam_list.dart';

class ExamBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Common.portraitModeOnly();
    //
    return Container(
      child: ExamList(),
    );
  }
//End
}
