import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart' as Theme;
import '../../main.dart';
import '../../models/my_app_model.dart';
import '../../models/user.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  //App Bar Title
  final String _title;
  HomeAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.white),
      title: Row(
        children: <Widget>[
          Image.asset('assets/images/kwiq-logo.png',
              height: Theme.Dimens.kwiqLogoHeight,
              width: Theme.Dimens.kwiqLogoWidth,
              fit: BoxFit.contain),
          SizedBox(
            width: 10.0,
          ),
          Text(
            _title,
            style: Theme.TextStyles.appBarTitle,
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      brightness: Brightness.dark,
      elevation: 1.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.white,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          color: Colors.white,
          onPressed: () => _onAccountTap(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  _onAccountTap(BuildContext context) {
    final model = Provider.of<MyAppModel>(context);
    final User user = model.getUser();
    if (user != null) {
      Navigator.pushNamed(context, AccountRoute);
    } else {
      Navigator.pushNamed(context, LoginRoute);
    }
  }
}
