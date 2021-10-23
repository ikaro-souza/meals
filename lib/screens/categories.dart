import 'package:flutter/material.dart';
import 'package:meals/constants.dart';
import 'package:meals/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mah Meals'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(filtersRoute),
            icon: const Icon(Icons.filter_alt),
          )
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 16,
          maxCrossAxisExtent: 184,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        children: _buildCategoryItems(),
      ),
    );
  }

  List<Widget> _buildCategoryItems() {
    return dummyCategories.map((e) => CategoryItem(category: e)).toList();
  }
}
