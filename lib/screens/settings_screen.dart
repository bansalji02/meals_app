import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meals_app/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  //here accepting the function from the main dart file for changing the filters so creating a constucter
  final Function setFilters;
  final Map<String, bool> currentFilters;

  SettingsScreen(this.currentFilters, this.setFilters);

  static const routeName = '/setting_screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;

  //i still dont know why we use this, i only know that it is used to initialize
  @override
  initState() {
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget _buildPreferenceList(String prefTitle, String prefSubtitle,
      bool prefValue, Function updateValue) {
    return SwitchListTile(
      title: Text(prefTitle),
      value: prefValue,
      subtitle: Text(prefSubtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'Choose your meal preferences here!',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        _buildPreferenceList(
          'Is Gluten Free?',
          'Show only Gluten free meals',
          _isGlutenFree,
          (newValue) {
            setState(() {
              _isGlutenFree = newValue;
            });
          },
        ),
        _buildPreferenceList(
          'Is Lactose Free?',
          'Show Only Lactose free meals',
          _isLactoseFree,
          (newValue) {
            setState(() {
              _isLactoseFree = newValue;
            });
          },
        ),
        _buildPreferenceList(
          'Is Vegan?',
          'Show only Vegan meals',
          _isVegan,
          (newValue) {
            setState(() {
              _isVegan = newValue;
            });
          },
        ),
        _buildPreferenceList(
          'Is Vegetarian?',
          'Show only Vegetarian meals',
          _isVegetarian,
          (newValue) {
            setState(() {
              _isVegetarian = newValue;
            });
          },
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          //here in the onpressed we have to pass the values of the filters in the setfilters method inorder to pass them in the main file othervise it will pass null which will give error

          onPressed: (() {
            //here we have created a map selectedFilters which will store the modified value from above
            final selectedFilters = {
              'gluten': _isGlutenFree,
              'lactose': _isLactoseFree,
              'vegan': _isVegan,
              'vegetarian': _isVegetarian,
            };

            widget.setFilters(selectedFilters);

            Fluttertoast.showToast(
                msg: 'Your settings are saves successfully',
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_SHORT);
          }),
          child: const Text(
            'Save Changes!',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
        ),
      ]),
    );
  }
}
