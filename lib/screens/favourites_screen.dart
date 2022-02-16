import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  //accepting the favourite meal list
  final List<Meal> favouriteMeal;

  FavoritesScreen(this.favouriteMeal);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty) {
      return const Center(
        child: Text('This is the fucking favorite screen'),
      );
    } else {
      return Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              affordability: favouriteMeal[index].affordability,
              complexity: favouriteMeal[index].complexity,
              title: favouriteMeal[index].title,
              imageUrl: favouriteMeal[index].imageUrl,
              duration: favouriteMeal[index].duration,
              id: favouriteMeal[index].id,
            );
          },
          itemCount: favouriteMeal.length,
        ),
      );
    }
  }
}
