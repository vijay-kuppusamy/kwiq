import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/my_app_model.dart';
import '../models/user.dart';
import '../theme/theme.dart' as Theme;
import '../main.dart';

class KwiqDrawer extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: getDrawer(context),
    );
  }

  getDrawer(BuildContext context) {
    final model = Provider.of<MyAppModel>(context);
    final User user = model.getUser();
    if (user != null) {
      return getLogggedInDrawer(context, model, user);
    } else {
      return getLogInDrawer(context);
    }
  }

  getLogInDrawer(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('Home', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeRoute);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('About Us', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              // change app state...
              Navigator.pushNamed(context, ArticleScreenRoute,
                  arguments: {"name": "About Kwiq"});
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('Login', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushNamed(context, LoginRoute);
            },
          ),
        ),
      ]).toList(),
    );
  }

  getLogggedInDrawer(BuildContext context, MyAppModel model, User user) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        new UserAccountsDrawerHeader(
          accountName: Text(user.getEmail(), style: Theme.TextStyles.kwiqUser),
          accountEmail: Text(user.getName(), style: Theme.TextStyles.kwiqUser),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('Home', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeRoute);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('About Us', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              // change app state...
              Navigator.pushNamed(context, ArticleScreenRoute,
                  arguments: {"name": "About Kwiq"});
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          //color: Colors.white,
          child: ListTile(
            title: Text('Account', style: Theme.TextStyles.kwiqContent),
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('My Account', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushNamed(context, AccountRoute);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('My Exams', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              // change app state...
              Navigator.pushNamed(context, MyExamListRoute,
                  arguments: {"userId": user.getId()});
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('Change Password', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushNamed(context, EditAccountRoute);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
          color: Colors.white70,
          child: ListTile(
            title: Text('Logout', style: Theme.TextStyles.kwiqContent),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeRoute, (Route<dynamic> route) => false);
              model.setUser(null);
            },
          ),
        ),
      ]).toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
