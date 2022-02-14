import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/bottom_tabs_screen.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //writing the logic to implement the filters, for that creating a map here for the filters
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  //Making a new list of available meals to apply filteres on
  List<Meal> _availableMeals;

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }

        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }

        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }

        if (_filters['vegetarian'] && !element.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.brown),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                subtitle1: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.deepOrange)),
      //home: BottomTabsScreen(),
      routes: {
        //instead of changing the home option in main dart file we can change the bootup screen using a default root routes tab as
        '/': (ctx) => BottomTabsScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(_filters,
            _setFilters), //the first parameter we are passing is currentfilter to show the changed value in filter screen
      },
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      // }, onGenerateRoute and onUnknownRoute are two methods to make sure something happens or some navigation occurs if there are no routes specified in the routes
    );
  }
}

// the code below this wont be used now cauze we are taking the categories screen as the entry point of our app
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Meals App'),
      ),
      body: const Text('Body of the app'),
    );
  }
}
