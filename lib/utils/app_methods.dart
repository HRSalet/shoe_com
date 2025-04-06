import 'package:flutter/material.dart';
import 'package:sneakers_app/data/dummy_data.dart';
import 'package:sneakers_app/widget/snack_bar.dart';

import '../models/models.dart';

class AppMethods {
  AppMethods._();
  static void addToCart(Product data, BuildContext context) {
    bool contains = itemsOnBag.contains(data);

    if (contains == true) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar());
    } else {
      itemsOnBag.add(data);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
    }
  }

  static void addToWish(Product data, BuildContext context) {
    bool contains = itemsOnWishlist.contains(data);

    if (contains == true) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(emptySnackBar());
    } else {
      itemsOnWishlist.add(data);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
    }
  }

  static void removeFromWish(Product data, BuildContext context) {
    itemsOnWishlist.remove(data);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(emptySnackBar());
  }

  static double sumOfItemsOnBag() {
    return itemsOnBag.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}
