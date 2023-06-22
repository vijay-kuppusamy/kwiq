import 'package:flutter/material.dart';

import '../theme/theme.dart' as Theme;

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  //App Bar Title
  final String _title;

  CommonAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.white),
      title: Text(
        _title,
        style: Theme.TextStyles.appBarTitle,
      ),
      backgroundColor: Colors.transparent,
      brightness: Brightness.dark,
      elevation: 1.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
