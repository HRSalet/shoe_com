import 'package:flutter/material.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';
import 'package:sneakers_app/view/checkout/checkout_screen.dart';

import '../../../../utils/app_methods.dart';
import '../../../animation/fadeanimation.dart';
import '../../../data/dummy_data.dart';
import '../../../models/models.dart';
import '../../../utils/constants.dart';
import '../../../view/bag/widget/empty_list.dart';

class BodyBagView extends StatefulWidget {
  const BodyBagView({super.key});

  @override
  _BodyBagViewState createState() => _BodyBagViewState();
}

class _BodyBagViewState extends State<BodyBagView>
    with SingleTickerProviderStateMixin {
  int lengthsOfItemsOnBag = itemsOnBag.length;

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
            itemsOnBag.isEmpty
                ? EmptyList()
                : Column(
                  children: [
                    mainListView(width, height),
                    SizedBox(height: 12),
                    bottomInfo(width, height),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  // Top Texts Components
  topText(width, height) {
    return SizedBox(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Bag", style: AppThemes.bagTitle),
            Text(
              "Total ${itemsOnBag.fold(0, (sum, item) => sum + item.quantity)} Items",
              style: AppThemes.bagTotalPrice,
            ),
          ],
        ),
      ),
    );
  }

  mainListView(width, height) {
    return Container(
      width: width,
      height: height / 1.7,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemsOnBag.length,
        itemBuilder: (ctx, index) {
          Product currentBagItem = itemsOnBag[index];
          return FadeAnimation(
            delay: 1.5 * index / 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1),
              width: width,
              height: height / 5.3,
              child: Row(
                children: [
                  SizedBox(
                    width: width / 2.8,
                    height: height / 6,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
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
                              image: NetworkImage(currentBagItem.imgAddress),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currentBagItem.model,
                          style: AppThemes.bagProductModel,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\₹ ${currentBagItem.price}",
                          style: AppThemes.bagProductPrice,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (currentBagItem.quantity > 1) {
                                    currentBagItem.quantity -=
                                        1; // Decrease quantity
                                  } else {
                                    itemsOnBag.remove(
                                      currentBagItem,
                                    ); // Remove item if quantity is 1
                                  }
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Center(
                                  child: Icon(Icons.remove, size: 15),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${currentBagItem.quantity}",
                              style: AppThemes.bagProductNumOfShoe,
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentBagItem.quantity +=
                                      1; // Increase quantity
                                });
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                child: Center(child: Icon(Icons.add, size: 15)),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  materialButton(width, height) {
    return FadeAnimation(
      delay: 3,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minWidth: width / 1.2,
        height: height / 15,
        color: AppConstantsColor.materialButtonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutScreen()),
          );
        },
        child: Text(
          "CHECKOUT",
          style: TextStyle(color: AppConstantsColor.lightTextColor),
        ),
      ),
    );
  }

  bottomInfo(width, height) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: height / 5,
      child: Column(
        children: [
          FadeAnimation(
            delay: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(" TOTAL", style: AppThemes.bagTotalPrice),
                Text(
                  "\₹${AppMethods.sumOfItemsOnBag()}",
                  style: AppThemes.bagSumOfItemOnBag,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          materialButton(width, height),
        ],
      ),
    );
  }
}
