import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/store.dart';
import 'package:provider/provider.dart';

typedef BuilderFunction = Widget Function();

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Consumer<Store>(
                builder: (_, store, __) {
                  final isFavorite = store.favoriteMeals.contains(meal);
                  final icon =
                      isFavorite ? Icons.favorite : Icons.favorite_border;
                  return IconButton(
                    onPressed: () {
                      if (!isFavorite) {
                        store.addFavoriteMeal(meal);
                      } else {
                        store.removeFavoriteMeal(meal);
                      }
                    },
                    icon: Icon(icon),
                  );
                },
              )
            ],
            expandedHeight: MediaQuery.of(context).size.height / 3,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(meal.title),
              background: Hero(
                tag: meal.imageUrl,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              titlePadding: const EdgeInsets.all(12),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, __) {
                final theme = Theme.of(context);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildSection(
                        'Ingredients',
                        context,
                        () {
                          return Column(
                            children: _buildIngredientsTiles(theme),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        'Steps',
                        context,
                        () {
                          return Column(
                            children: _buildStepsTiles(theme),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIngredientsTiles(ThemeData theme) {
    return meal.ingredients
        .map(
          (e) => ListTile(
            title: Text(
              e,
              style: _getSectionListItemTextStyle(theme),
            ),
            dense: true,
          ),
        )
        .toList();
  }

  List<Widget> _buildStepsTiles(ThemeData theme) {
    return meal.steps
        .map(
          (e) => ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.primaryColor,
              child: Text(
                (meal.steps.indexOf(e) + 1).toString(),
              ),
            ),
            title: Text(
              e,
              style: _getSectionListItemTextStyle(theme),
            ),
            dense: true,
          ),
        )
        .toList();
  }

  Widget _buildSection(
    String title,
    BuildContext context,
    BuilderFunction builder,
  ) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: _getSectionTitleTextStyle(theme),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: builder(),
        ),
      ],
    );
  }

  TextStyle _getSectionTitleTextStyle(ThemeData theme) {
    return theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle _getSectionListItemTextStyle(ThemeData theme) {
    return theme.textTheme.subtitle2!.copyWith(fontWeight: FontWeight.normal);
  }
}
