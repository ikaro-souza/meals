import 'package:flutter/material.dart';

import 'filters.dart';
import 'meal.dart';

class Store extends ChangeNotifier {
  final Filters _filters = Filters();
  List<Meal> _favoriteMeals = [];

  Filters get filters => _filters;

  List<Meal> get favoriteMeals => _favoriteMeals;

  void update({Filters? filters, List<Meal>? favoriteMeals}) {
    _filters.from(filters);

    if (favoriteMeals != null) {
      _favoriteMeals = favoriteMeals;
    }

    notifyListeners();
  }

  void addFavoriteMeal(Meal meal) {
    _favoriteMeals.add(meal);
    notifyListeners();
  }

  void removeFavoriteMeal(Meal meal) {
    _favoriteMeals.removeWhere((e) => e == meal);
    notifyListeners();
  }
}
