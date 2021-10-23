import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBorderRadius = BorderRadius.circular(12);

    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: cardBorderRadius,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: cardBorderRadius,
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: _getTitleTextStyle(theme),
        ),
      ),
    );
  }

  TextStyle _getTitleTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle1!.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed(
      categoryMealsRoute,
      arguments: category,
    );
  }
}
