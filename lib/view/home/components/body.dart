import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_app/theme/custom_app_theme.dart';

import '../../../../animation/fadeanimation.dart';
import '../../../../models/shoe_model.dart';
import '../../../../utils/constants.dart';
import '../../../../view/detail/detail_screen.dart';
import '../../../data/dummy_data.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndexOfCategory = 0;

  List<ShoeModel> getFilteredShoes() {
    String selectedCategory = categories[selectedIndexOfCategory];
    if (selectedCategory == 'Nike') {
      return nikeShoes;
    } else if (selectedCategory == 'Adidas') {
      return adidasShoes;
    } else if (selectedCategory == 'Bata') {
      return bataShoes;
    } else if (selectedCategory == 'Puma') {
      return pumaShoes;
    } else if (selectedCategory == 'Campus') {
      return CampusShoes;
    } else if (selectedCategory == 'Woodland') {
      return woodlandShoes;
    } else if (selectedCategory == 'Reebok') {
      return reebokShoes;
    }
    return nikeShoes;
  }

  void toggleWishlist(ShoeModel model) {
    setState(() {
      if (itemsOnWishlist.contains(model)) {
        itemsOnWishlist.remove(model);
      } else {
        itemsOnWishlist.add(model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          topCategoriesWidget(width, height),
          SizedBox(height: 10),
          middleCategoriesWidget(width, height),
          SizedBox(height: 5),
          moreTextWidget(),
          lastCategoriesWidget(width, height),
        ],
      ),
    );
  }

  // Top Categories Widget
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

  // Middle Categories Widget
  Widget middleCategoriesWidget(double width, double height) {
    List<ShoeModel> filteredShoes = getFilteredShoes();

    return Row(
      children: [
        Container(
          width: width,
          height: height / 2.4,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: filteredShoes.length,
            itemBuilder: (ctx, index) {
              ShoeModel model = filteredShoes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (ctx) => DetailScreen(
                            model: model,
                            isComeFromMoreSection: false,
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
                          color: model.modelColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        child: FadeAnimation(
                          delay: 1,
                          child: Row(
                            children: [
                              Text(
                                model.name,
                                style: AppThemes.homeProductName,
                              ),
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
                            model.model,
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
                            "\₹${model.price.toStringAsFixed(2)}",
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
                            tag: model.imgAddress,
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(-30 / 360),
                              child: Image.asset(
                                model.imgAddress,
                                width: 230,
                                height: 230,
                                fit: BoxFit.fitWidth,
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
        ),
      ],
    );
  }

  // More Text Widget
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

  // Last Categories Widget (Updated to Show Filtered Shoes)
  Widget lastCategoriesWidget(double width, double height) {
    List<ShoeModel> filteredShoes = getFilteredShoes();

    return Container(
      width: width,
      height: height / 4,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: filteredShoes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          ShoeModel model = filteredShoes[index];
          bool isFavorite = itemsOnWishlist.contains(model);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (ctx) => DetailScreen(
                        model: model,
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
                        toggleWishlist(model);
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
                        child: Image.asset(
                          model.imgAddress,
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
