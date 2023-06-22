import 'package:flutter/material.dart';

class CommonWidgets {
  //Box Shadow
  static List<BoxShadow> getBoxShadow() {
    return [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 0.5, // has the effect of softening the shadow
        spreadRadius: 0.5, // has the effect of extending the shadow
        offset: Offset(
          0.5, // horizontal, move right 10
          0.5, // vertical, move down 10
        ),
      )
    ];
  }
}
