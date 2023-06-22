import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_app_model.dart';
import '../../models/user.dart';
import '../../theme/theme.dart' as Theme;
import '../../components/common_app_bar.dart';

class Account extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyAppModel>(context);
    final User user = model.getUser();

    final name = user?.getName() ?? "";
    final email = user?.getEmail() ?? "";

    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/app-bg.png',
          height: _height,
          width: _width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonAppBar("Account Details"),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white54,
            ),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white70,
              ),
              child: Column(
                children: <Widget>[
                  new SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      //height: _height * 0.10,
                      width: _width * 0.95,
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black45),
                      )),
                      child: Row(
                        children: <Widget>[
                          Text("Name : ", style: Theme.TextStyles.kwiqContent),
                          Text(name,
                              style: Theme.TextStyles.kwiqContent,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      )),
                  Container(
                    //height: _height * 0.10,
                    width: _width * 0.95,
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.black45),
                    )),
                    child: Row(
                      children: <Widget>[
                        Text("Email : ", style: Theme.TextStyles.kwiqContent),
                        Text(email,
                            style: Theme.TextStyles.kwiqContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
