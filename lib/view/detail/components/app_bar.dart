import 'package:flutter/material.dart';
import 'package:sneakers_app/data/dummy_data.dart'; // Import wishlist data
import 'package:sneakers_app/models/shoe_model.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';
import 'package:sneakers_app/utils/constants.dart';

PreferredSize? customAppBarDe(
  BuildContext ctx,
  String title,
  Product productModel,
) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: StatefulBuilder(
      builder: (context, setState) {
        bool isFavorite = itemsOnWishlist.contains(
          productModel,
        ); // Check if in wishlist

        return AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(title, style: AppThemes.detailsAppBar), // Dynamic title
          leading: IconButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppConstantsColor.darkTextColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // setState(() {
                //   if (isFavorite) {
                //     itemsOnWishlist.remove(productModel);
                //   } else {
                //     itemsOnWishlist.add(productModel);
                //   }
                // });
              },
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border, // Change icon
                color: isFavorite ? Colors.pink : Colors.white, // Change color
              ),
            ),
          ],
        );
      },
    ),
  );
}
