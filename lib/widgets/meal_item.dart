import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.meal,
    required this.removeMeal,
  }) : super(key: key);

  final Meal meal;
  final Function removeMeal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => _onMealTap(context),
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Hero(
                      tag: meal.imageUrl,
                      child: Image.network(
                        meal.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.25),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            meal.title,
                            style: _getTitleTextStyle(theme),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(width: 4),
                      Text('${meal.duration}min')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.work_outlined),
                      const SizedBox(width: 4),
                      Text(meal.displayComplexity)
                    ],
                  ),
                  Text(meal.displayAffordability),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getTitleTextStyle(ThemeData theme) {
    return theme.textTheme.headline6!.copyWith(color: Colors.white);
  }

  void _onMealTap(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          mealDetailsRoute,
          arguments: meal,
        )
        .then((value) => removeMeal.call(value));
  }
}
