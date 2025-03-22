import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../animation/fadeanimation.dart';
import '../../../data/dummy_data.dart';
import '../../../models/shoe_model.dart';
import '../../../theme/custom_app_theme.dart';
import 'empty_list.dart';

class WishlistBodyView extends StatefulWidget {
  const WishlistBodyView({super.key});

  @override
  State<WishlistBodyView> createState() => _WishlistBodyViewState();
}

class _WishlistBodyViewState extends State<WishlistBodyView>
    with SingleTickerProviderStateMixin {
  int lengthsOfItemsOnWish = itemsOnWishlist.length;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: width,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            topText(width, height),
            Divider(color: Colors.grey),
            itemsOnWishlist.isEmpty
                ? WishEmptyList()
                : Column(children: [mainListView(width, height)]),
          ],
        ),
      ),
    );
  }

  mainListView(width, height) {
    return SizedBox(
      width: width,
      height: height / 1,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemsOnWishlist.length,
        itemBuilder: (ctx, index) {
          ShoeModel currentBagItem = itemsOnWishlist[index];
          return FadeAnimation(
            delay: 1.5 * index / 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1),
              width: width,
              height: height / 5.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 2.8,
                    height: height / 5.7,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 10,
                          child: Container(
                            width: width / 3.6,
                            height: height / 7.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[350],
                            ),
                            child: Image(
                              fit: BoxFit.contain,
                              image: AssetImage(currentBagItem.imgAddress),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentBagItem.model,
                          style: AppThemes.bagProductModel,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$${currentBagItem.price}",
                          style: AppThemes.bagProductPrice,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        itemsOnWishlist.remove(currentBagItem);
                        lengthsOfItemsOnWish = itemsOnBag.length;
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  topText(width, height) {
    return Container(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("My Wishlist", style: AppThemes.bagTitle)],
        ),
      ),
    );
  }
}
