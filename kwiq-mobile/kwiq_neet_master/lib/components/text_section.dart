import 'package:flutter/material.dart';

import '../theme/theme.dart' as Theme;

class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  static const double _hPad = 5.0;

  TextSection(this._title, this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(_hPad, 5.0, _hPad, 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.black54),
              ),
            ),
            child: Text(_title, style: Theme.TextStyles.kwiqItemTitle)),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: _hPad),
            child: Text(_body,
                style: Theme.TextStyles.kwiqContent,
                maxLines: 7,
                overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
