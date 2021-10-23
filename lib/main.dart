import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/models/store.dart';
import 'package:meals/screens/category_meals.dart';
import 'package:meals/screens/favorites.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/screens/root.dart';
import 'package:provider/provider.dart';

import 'models/category.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Store(),
      child: MaterialApp(
        title: 'Meals',
        theme: ThemeData(
          primaryColor: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
            accentColor: Colors.purple,
          ).copyWith(secondary: Colors.tealAccent),
          splashColor: Colors.purple,
          toggleableActiveColor: Colors.purple,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.purple,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            selectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        initialRoute: homeRoute,
        onGenerateRoute: (settings) {
          final route = settings.name;

          switch (route) {
            case categoryMealsRoute:
              return CupertinoPageRoute(
                builder: (_) => CategoryMealsScreen(
                  category: settings.arguments as Category,
                ),
              );
            case mealDetailsRoute:
              return CupertinoPageRoute(
                builder: (_) =>
                    MealDetailsScreen(meal: settings.arguments as Meal),
              );
            case favoritesRoute:
              return CupertinoPageRoute(
                builder: (_) => const FavoritesScreen(),
              );
            case filtersRoute:
              return CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (_) => const FiltersScreen(),
              );
            default:
              return CupertinoPageRoute(
                builder: (_) => const RootScreen(),
              );
          }
        },
      ),
    );
  }
}
