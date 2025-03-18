// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';

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
    return Container(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Bag", style: AppThemes.bagTitle),
            Text(
              "Total ${lengthsOfItemsOnBag} Items",
              style: AppThemes.bagTotalPrice,
            ),
          ],
        ),
      ),
    );
  }

  // Material Button Components
  materialButton(width, height) {
    return FadeAnimation(
      delay: 3,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minWidth: width / 1.2,
        height: height / 15,
        color: AppConstantsColor.materialButtonColor,
        onPressed: () {
          //print("Button Pressed");
          showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 350,
                    child: Center(
                      child: Text(
                        'Choose payment method',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text('Cash on delivery'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Icon(Icons.money_outlined),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Paypal'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Icon(Icons.paypal),
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          "CHECKOUT",
          style: TextStyle(color: AppConstantsColor.lightTextColor),
        ),
      ),
    );
  }

  // Main ListView Components
  mainListView(width, height) {
    return Container(
      width: width,
      height: height / 1.6,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: itemsOnBag.length,
        itemBuilder: (ctx, index) {
          ShoeModel currentBagItem = itemsOnBag[index];
          return FadeAnimation(
            delay: 1.5 * index / 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1),
              width: width,
              height: height / 5.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width / 2.8,
                    height: height / 5.7,
                    child: Stack(
                      children: [
                        Container(
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
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
                          "\$${currentBagItem.price}",
                          style: AppThemes.bagProductPrice,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  itemsOnBag.remove(currentBagItem);
                                  lengthsOfItemsOnBag = itemsOnBag.length;
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
                            Text("1", style: AppThemes.bagProductNumOfShoe),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
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

  bottomInfo(width, height) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: width,
      height: height / 7,
      child: Column(
        children: [
          FadeAnimation(
            delay: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOTAL", style: AppThemes.bagTotalPrice),
                Text(
                  "\$${AppMethods.sumOfItemsOnBag()}",
                  style: AppThemes.bagSumOfItemOnBag,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          materialButton(width, height),
        ],
      ),
    );
  }
}
