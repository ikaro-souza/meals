import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/store.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  List<Meal> meals = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      meals = _filterMeals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: meals.length,
        itemBuilder: (_, i) {
          return MealItem(
            meal: meals[i],
            removeMeal: _removeMeal,
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }

  void _removeMeal(String id) {
    setState(() {
      meals.removeWhere((element) => element.id == id);
    });
  }

  List<Meal> _filterMeals() {
    final store = Provider.of<Store>(context);

    List<Meal> meals = List.from(
      dummyMeals.where(
        (element) => element.categories.contains(widget.category.id),
      ),
    );

    meals.removeWhere(
      (m) =>
          store.filters.vegan && !m.isVegan ||
          store.filters.vegetarian && !m.isVegetarian ||
          store.filters.glutenFree && !m.isGlutenFree ||
          store.filters.lactoseFree && !m.isLactoseFree,
    );
    return meals;
  }
}
