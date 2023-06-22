import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../subject/subject_body.dart';
import '../../models/my_app_model.dart';

class CourseBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool loadData = false;
    //App State Model
    final model = Provider.of<MyAppModel>(context);
    if (model.getSubjects() == null) {
      loadData = true;
    }
    return SubjectBody(loadData);
  }
}
