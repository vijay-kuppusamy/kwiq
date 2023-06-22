import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/my_app_model.dart';

class CommonNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //App State Model
    final model = Provider.of<MyAppModel>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          title: Text('Course'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          title: Text('Exam'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
      currentIndex: getIndex(model),
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.blue,
      onTap: (index) => {model.setHomePageIndex(index)},
    );
  }

  getIndex(MyAppModel model) {
    return model.getHomePageIndex();
  }
}
