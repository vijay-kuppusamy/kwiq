import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class VideoBody extends StatelessWidget {
  //
  final String name;
  final String videoUrl;

  VideoBody({Key key, this.name, this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Screen width and height
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return HtmlWidget(
      getkHtml(videoUrl, _width * 0.90, _height * 0.30),
      webView: true,
    );
  }

  getkHtml(String videoUrl, double width, double height) {
    String kHtml = """
    <iframe src="$videoUrl" width="$width" height="$height"></iframe>
    """;
    return kHtml;
  }
}
