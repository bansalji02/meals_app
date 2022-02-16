//this screen is used if we want to add a bottom navigation bar in the app

import 'package:flutter/material.dart';
import 'package:meals_app/main_drawer.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';

class BottomTabsScreen extends StatefulWidget {
  //accepting the favourite meals argument
  final List<Meal> favouriteMeals;

  BottomTabsScreen(this.favouriteMeals);

  @override
  State<BottomTabsScreen> createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  List<Widget> _pages;

  int _selectedPageIndex = 0;

  //here we need to use init state to initialize the _pages because the favouritescreeen cant be intialized up there
  @override
  void initState() {
    _pages = [CategoriesScreen(), FavoritesScreen(widget.favouriteMeals)];
    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deli meals'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
