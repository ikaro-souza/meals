import 'package:flutter/material.dart';
import 'package:meals/models/store.dart';
import 'package:meals/models/filters.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _selectedVegan;
  bool? _selectedVegetarian;
  bool? _selectedGlutenFree;
  bool? _selectedLactoseFree;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final store = Provider.of<Store>(context);

    _selectedVegan = store.filters.vegan;
    _selectedVegetarian = store.filters.vegetarian;
    _selectedGlutenFree = store.filters.glutenFree;
    _selectedLactoseFree = store.filters.lactoseFree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 0,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Dietary',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterTile(
                title: 'Vegan',
                value: _selectedVegan ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedVegan = value;
                  });
                },
              ),
              _buildFilterTile(
                title: 'Vegeterian',
                value: _selectedVegetarian,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedVegetarian = value;
                  });
                },
              ),
              _buildFilterTile(
                title: 'Gluten free',
                value: _selectedGlutenFree,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedGlutenFree = value;
                  });
                },
              ),
              _buildFilterTile(
                title: 'Lactose free',
                value: _selectedLactoseFree,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedLactoseFree = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: const Text('APPLY'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterTile({
    required String title,
    required bool? value,
    required void Function(bool?) onChanged,
    String? subtitle,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value ?? false,
      onChanged: onChanged,
    );
  }

  void _applyFilters() {
    final store = Provider.of<Store>(context, listen: false);
    store.update(
      filters: Filters(
        vegan: _selectedVegan ?? false,
        vegetarian: _selectedVegetarian ?? false,
        glutenFree: _selectedGlutenFree ?? false,
        lactoseFree: _selectedLactoseFree ?? false,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Filters applied!'),
        action: SnackBarAction(
          label: 'Check',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
