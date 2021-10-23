class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final MealComplexity complexity;
  final MealAffordability affordability;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.complexity,
    required this.affordability,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.steps,
    this.isGlutenFree = false,
    this.isVegan = false,
    this.isVegetarian = false,
    this.isLactoseFree = false,
  });

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return (other as Meal).id == id;
  }
}

extension MealExtensions on Meal {
  String get displayComplexity {
    switch (complexity) {
      case MealComplexity.simple:
        return 'Simple';
      case MealComplexity.challenging:
        return 'Challenging';
      case MealComplexity.hard:
        return 'Hard';
      default:
        return 'Unkown';
    }
  }

  String get displayAffordability {
    switch (affordability) {
      case MealAffordability.affordable:
        return '\$';
      case MealAffordability.pricey:
        return '\$\$';
      case MealAffordability.luxurious:
        return '\$\$\$';
      default:
        return 'Unkown';
    }
  }
}

enum MealComplexity {
  simple,
  challenging,
  hard,
}

enum MealAffordability {
  affordable,
  pricey,
  luxurious,
}
