import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/store.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites meals'),
        elevation: 0,
      ),
      body: Consumer<Store>(
        builder: (_, store, child) => ListView.separated(
          itemBuilder: (_, i) {
            final meal = store.favoriteMeals[i];

            return ListTile(
              onTap: () => Navigator.of(context).pushNamed(
                mealDetailsRoute,
                arguments: meal,
              ),
              title: Text(meal.title),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () => _onFavoritePressed(context, meal),
              ),
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(height: 16);
          },
          itemCount: store.favoriteMeals.length,
        ),
      ),
    );
  }

  Future _onFavoritePressed(BuildContext context, Meal meal) async {
    final shouldRemove = await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('Remove meal from favorites?'),
          content: const Text(
              'This action will remove the meal from your favorite list.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('No'),
              isDefaultAction: true,
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text('Yes'),
              isDestructiveAction: true,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldRemove == true) {
      Provider.of<Store>(context, listen: false).removeFavoriteMeal(meal);
    }
  }
}
