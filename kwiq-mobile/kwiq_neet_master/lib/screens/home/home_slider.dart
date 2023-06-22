import 'package:flutter/material.dart';
import '../../components/carousel_slider.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() {
    return _HomeSliderState();
  }
}

class _HomeSliderState extends State<HomeSlider> {
  //
  //int _current = 0;

  List<Widget> getSliderItems(double width) {
    List<Widget> items = [
      constructSliderItem('assets/images/kwiq-banner1.png', "", "", width),
      constructSliderItem('assets/images/kwiq-banner2.png', "", "", width),
      constructSliderItem('assets/images/kwiq-banner3.png', "", "", width),
    ];
    return items;
  }

  final TextStyle titleStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  Widget constructSliderItem(
      String imageUri, String title, String body, double _width) {
    return Stack(children: <Widget>[
      Image.asset(
        imageUri,
        width: _width,
        fit: BoxFit.fill,
      ),
      Center(
          child: Text(
        title,
        style: titleStyle,
      )),
    ]);
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Stack(children: [
      CarouselSlider(
        viewportFraction: 1.0,
        aspectRatio: 16 / 9,
        autoPlay: true,
        enlargeCenterPage: false,
        items: getSliderItems(_width),
        onPageChanged: (index) {
          setState(() {
            //_current = index;
          });
        },
      ),
    ]);
  }
}
