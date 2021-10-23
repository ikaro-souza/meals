import 'package:flutter/material.dart';

class Filters {
  bool vegan;
  bool vegetarian;
  bool glutenFree;
  bool lactoseFree;

  Filters({
    this.vegan = false,
    this.vegetarian = false,
    this.glutenFree = false,
    this.lactoseFree = false,
  }) : super();

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    final _other = other as Filters;

    return vegan == _other.vegan &&
        vegetarian == _other.vegetarian &&
        glutenFree == _other.glutenFree &&
        lactoseFree == _other.lactoseFree;
  }

  void from(Filters? filters) {
    vegan = filters?.vegan ?? vegan;
    vegetarian = filters?.vegan ?? vegetarian;
    glutenFree = filters?.glutenFree ?? glutenFree;
    lactoseFree = filters?.lactoseFree ?? lactoseFree;
  }
}
