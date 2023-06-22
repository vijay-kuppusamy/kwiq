import 'package:flutter/material.dart';

import '../../components/common_app_bar.dart';
import '../../html/flutter_html.dart';
import '../../common/common.dart';

class ArticleScreen extends StatelessWidget {
  final String name;
  //
  ArticleScreen({this.name});
  //
  @override
  Widget build(BuildContext context) {
    //
    String content = "";
    if (name == "About NEET") {
      content = Common.getAboutNEET();
    } else if (name == "About Kwiq") {
      content = Common.getAboutKwiq();
    }
    //double _width = MediaQuery.of(context).size.width;

    return Stack(children: <Widget>[
      Image.asset(
        'assets/images/app-bg.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(name),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white70),
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          child: buildArticleScreen(context, content),
        ),
      ),
    ]);
  }

  buildArticleScreen(BuildContext context, String content) {
    return Container(
      child: Html(
          data: getTextWithHTML(content),
          padding: EdgeInsets.all(8.0),
          backgroundColor: Colors.white70,
          defaultTextStyle: TextStyle(fontFamily: 'serif'),
          useRichText: true),
    );
  }

  getTextWithHTML(String text) {
    return Common.addHTMLTags(text);
  }
}
