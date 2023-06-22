import 'package:flutter/material.dart';

import '../../components/common_app_bar.dart';
import '../../theme/theme.dart' as Theme;
import '../../main.dart';

class Info extends StatelessWidget {
  final String message;
  //
  Info({this.message});
  //
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
        appBar: CommonAppBar("Message"),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: buildEndExamMsg(context),
        ),
      ),
    ]);
  }

  buildEndExamMsg(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white70),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(10.0),
              child: Text(
                message,
                style: Theme.TextStyles.kwiqSubTitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            width: _width * 0.70,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.all(10),
                onPressed: () => _login(context),
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: Theme.TextStyles.button,
                ),
              ),
            ),
          ),
          Container(
            width: _width * 0.70,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue,
              child: MaterialButton(
                minWidth: double.infinity,
                padding: EdgeInsets.all(10),
                onPressed: () => _home(context),
                child: Text(
                  "Go To Home",
                  textAlign: TextAlign.center,
                  style: Theme.TextStyles.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    //
    Navigator.pushReplacementNamed(context, LoginRoute);
  }

  void _home(BuildContext context) {
    //
    Navigator.pushReplacementNamed(context, HomeRoute);
  }
}
