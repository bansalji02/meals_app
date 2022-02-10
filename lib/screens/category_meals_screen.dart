import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  /* final String categoryId;
  final String categoryTitle;

  CategoryMealsScreen(this.categoryId , this.categoryTitle);*/ //this commented out method will be used to pass the values if we choose the other way of navigation

  //making the routeName variable to use in the main dart file
  static const routeName = '/category-meals-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final filteredCategoryMeals = DUMMY_MEALS.where((element) {
      return element.categories.contains(categoryId);
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              affordability: filteredCategoryMeals[index].affordability,
              complexity: filteredCategoryMeals[index].complexity,
              title: filteredCategoryMeals[index].title,
              imageUrl: filteredCategoryMeals[index].imageUrl,
              duration: filteredCategoryMeals[index].duration,
              id: filteredCategoryMeals[index].id,
            );
          },
          itemCount: filteredCategoryMeals.length,
        ));
  }
}
