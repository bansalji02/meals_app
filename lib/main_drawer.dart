import 'package:flutter/material.dart';
import 'package:meals_app/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget drawerItems(
      String listTitle, IconData listIcon, Function onTapHandler) {
    return ListTile(
      leading: Icon(listIcon),
      title: Text(listTitle,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
      onTap: () => onTapHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'RobotoCondensed'),
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(
            height: 20,
          ),
          drawerItems('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          drawerItems('Settings', Icons.settings, () {
            Navigator.of(context)
                .pushReplacementNamed(SettingsScreen.routeName);
          }),
        ],
      ),
    );
  }
}
