import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_app_model.dart';
import '../../components/common_app_bar.dart';
import '../../theme/theme.dart' as Theme;
import '../../main.dart';

class EndExam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/app-bg.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar("End Exam"),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: buildEndExamMsg(context),
        ),
      ),
    ]);
  }

  buildEndExamMsg(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(10.0),
              child: Text(
                "The time allotted for the examination is elapsed. Please end the exam.",
                style: Theme.TextStyles.kwiqSubTitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () => _endExam(context),
                child: Text(
                  "End Exam",
                  textAlign: TextAlign.center,
                  style: Theme.TextStyles.button,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _endExam(BuildContext context) {
    //
    final model = Provider.of<MyAppModel>(context);

    model.updateStatus("Time Elapsed");
    Navigator.pushNamedAndRemoveUntil(
        context, ExamResultRoute, (Route<dynamic> route) => false,
        arguments: {"model": model});
  }
}
