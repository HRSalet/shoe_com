import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sneakers_app/theme/custom_app_theme.dart';
import 'package:sneakers_app/view/detail/detail_screen.dart';

import '../../../../animation/fadeanimation.dart';
import '../../../../models/shoe_model.dart';
import '../../../../utils/constants.dart';
import '../../../data/dummy_data.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndexOfCategory = 0;
  List<Product> products = [];
  List<String> categories = [
    "Nike",
    "Adidas",
    "Bata",
    "Reebok",
    "Puma",
    "Campus",
    "Woodland",
    "Reebok",
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts(categories[selectedIndexOfCategory].toLowerCase());
  }

  Future<void> fetchProducts(String category) async {
    final String url =
        "http://192.168.0.102/shoe_hive_db/index.php?category=$category";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);

        if (decodedData is Map<String, dynamic>) {
          if (decodedData.containsKey('products') &&
              decodedData['products'] is List) {
            setState(() {
              products =
                  (decodedData['products'] as List)
                      .map((item) => Product.fromJson(item))
                      .toList();
            });
          } else {
            print("Error: No products found.");
            setState(() {
              products = [];
            });
          }
        } else if (decodedData is List) {
          // If the response is already a List
          setState(() {
            products =
                decodedData.map((item) => Product.fromJson(item)).toList();
          });
        } else {
          throw Exception("Unexpected JSON format");
        }
      } else {
        throw Exception("Failed to load products");
      }
    } catch (error) {
      print("Error fetching products: $error");
    }
  }

  void toggleWishlist(Product product) {
    setState(() {
      if (itemsOnWishlist.contains(product)) {
        itemsOnWishlist.remove(product);
      } else {
        itemsOnWishlist.add(product);
      }
    });
  }

  Widget topCategoriesWidget(double width, double height) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            width: width,
            height: height / 18,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexOfCategory = index;
                    });
                    fetchProducts(categories[index].toLowerCase());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: selectedIndexOfCategory == index ? 21 : 18,
                        color:
                            selectedIndexOfCategory == index
                                ? AppConstantsColor.darkTextColor
                                : AppConstantsColor.unSelectedTextColor,
                        fontWeight:
                            selectedIndexOfCategory == index
                                ? FontWeight.bold
                                : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          topText(width, height),
          Divider(color: Colors.grey),
          topCategoriesWidget(width, height),
          Divider(color: Colors.grey),
          productListView(width, height),
          moreTextWidget(),
          lastCategoriesWidget(width, height),
        ],
      ),
    );
  }

  Widget topText(double width, double height) {
    return SizedBox(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: const Text("Discover", style: AppThemes.bagTitle),
            ),
            // IconButton(
            //   icon: FaIcon(
            //     CupertinoIcons.search,
            //     color: AppConstantsColor.darkTextColor,
            //     size: 25,
            //   ),
            //   onPressed: () {
            //     print('going for search');
            //     showSearch(context: context, delegate: ShoeSearchDelegate());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget productListView(double width, double height) {
    if (products.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      width: width,
      height: height / 2.4,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          Product product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetailScreen(
                        productModel: product,
                        isComeFromMoreSection: true,
                      ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(15),
              width: width / 1.5,
              child: Stack(
                children: [
                  Container(
                    width: width / 1.81,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: FadeAnimation(
                      delay: 1,
                      child: Row(
                        children: [
                          Text(product.name, style: AppThemes.homeProductName),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 10,
                    child: FadeAnimation(
                      delay: 1.5,
                      child: Text(
                        product.model,
                        style: AppThemes.homeProductModel,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 10,
                    child: FadeAnimation(
                      delay: 2,
                      child: Text(
                        "\₹${product.price.toStringAsFixed(2)}",
                        style: AppThemes.homeProductPrice,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 60,
                    child: FadeAnimation(
                      delay: 2,
                      child: Hero(
                        tag: product.imgAddress,
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(-30 / 360),
                          child: Image.network(
                            product.imgAddress,
                            width: 230,
                            height: 230,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.broken_image,
                                size: 100,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
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

  Widget moreTextWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text("More", style: AppThemes.homeMoreText),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: FaIcon(CupertinoIcons.arrow_right, size: 27),
          ),
        ],
      ),
    );
  }

  Widget lastCategoriesWidget(double width, double height) {
    if (products.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      width: width,
      height: height / 4,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          Product product = products[index];
          bool isFavorite = itemsOnWishlist.contains(product);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DetailScreen(
                        productModel: product,
                        isComeFromMoreSection: true,
                      ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: width / 2.24,
              height: height / 4.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    child: FadeAnimation(
                      delay: 1,
                      child: Container(
                        width: width / 13,
                        height: height / 10,
                        color: Colors.red,
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: Center(
                            child: FadeAnimation(
                              delay: 1.5,
                              child: Text(
                                "NEW",
                                style: AppThemes.homeGridNewText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        toggleWishlist(product);
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite
                                ? Colors.pink
                                : AppConstantsColor.darkTextColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 26,
                    left: 25,
                    child: FadeAnimation(
                      delay: 1.5,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(-15 / 360),
                        child: Image.network(
                          product.imgAddress,
                          width: width / 3,
                          height: height / 9,
                        ),
                      ),
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
}
