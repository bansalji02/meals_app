import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  //making a routeName variable exactly like we did in the category meals screen
  static const routeName = '/meal-detail-screen';

  //creating an function to accept the function passed in main file
  final Function toggleFavourite;
  final Function isFavMeal;

  MealDetailScreen(this.toggleFavourite, this.isFavMeal);

  //creating reusable widgets
  Widget titleText(String title, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }

  /*  Widget listOfInfo(Meal meal, BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        elevation: 4,
        color: Colors.brown,
        child: Text(
          meal.ingredients[index],
          style: const TextStyle(color: Colors.white, fontSize: 18,),
        ),
      ),
      itemCount: meal.ingredients.length,
    );
  } */

  @override
  Widget build(BuildContext context) {
//creating a mediaquery object to calculate the dynamic height of devices
    final mediaQueryObject = MediaQuery.of(context);

    //getting the arguments
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];
    final mealtitle = routeArgs['title'];

    //getting the selected meal inorder to extract more arguments
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealtitle as String),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: mediaQueryObject.size.height * 0.3,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(10)),
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            titleText('INGREDIENTS', context),
            Container(
              height: mediaQueryObject.size.height * 0.2,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  color: Colors.brown,
                  child: Center(
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            titleText('Steps to Cook', context),
            Container(
              height: mediaQueryObject.size.height * 0.5,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('#${index + 1}'),
                  ),
                  title: Text(selectedMeal.steps[index]),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(isFavMeal(mealId) ? Icons.star : Icons.star_border),
        elevation: 4,
        onPressed: () => toggleFavourite(mealId),
      ),
    );
  }
}
