import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../animation/fadeanimation.dart';
import '../../../../../models/shoe_model.dart';
import '../../../../../utils/constants.dart';
import '../../../data/dummy_data.dart';
import '../../../models/models.dart';
import '../../../theme/custom_app_theme.dart';
import '../../../utils/app_methods.dart' show AppMethods;
import '../../product_review/product_review_screen.dart';

class DetailsBody extends StatefulWidget {
  Product productModel;
  bool isComeFromMoreSection;
  DetailsBody({
    super.key,
    required this.productModel,
    required this.isComeFromMoreSection,
  });

  @override
  details createState() => details();
}

class details extends State<DetailsBody> {
  bool _isSelectedCountry = false;
  int? _isSelectedSize;
  bool isFavorite = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 1.1,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            topInformationWidget(width, height),
            SizedBox(
              height: 20,
              width: width / 1.1,
              child: Divider(thickness: 1.4, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  nameAndPrice(),
                  SizedBox(height: 10),
                  shoeInfo(width, height),
                  SizedBox(height: 10),
                  reviewWidget(width, height),
                  sizeTextAndCountry(width, height),
                  SizedBox(height: 10),
                  endSizesAndButton(width, height),
                  SizedBox(height: 20),
                  materialButton(width, height),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  topInformationWidget(width, height) {
    return SizedBox(
      width: width,
      height: height / 2.3,
      child: Stack(
        children: [
          Positioned(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppConstantsColor.darkTextColor,
              ),
            ),
          ),
          Positioned(
            left: 50,
            bottom: 20,
            child: FadeAnimation(
              delay: 0.5,
              child: Container(
                width: 1000,
                height: height / 2.2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1500),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    AppMethods.removeFromWish(widget.productModel, context);
                  } else {
                    AppMethods.addToWish(widget.productModel, context);
                  }
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 30,
            child: Hero(
              tag:
                  widget.isComeFromMoreSection
                      ? widget.productModel.model
                      : widget.productModel.imgAddress,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(-25 / 360),
                child: SizedBox(
                  width: width / 1.3,
                  height: height / 4.3,
                  child: Image.network(widget.productModel.imgAddress),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  nameAndPrice() {
    return FadeAnimation(
      delay: 1,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              widget.productModel.model,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppConstantsColor.darkTextColor,
              ),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text(
              '₹${widget.productModel.price.toStringAsFixed(2)}',
              style: AppThemes.detailsProductPrice,
            ),
          ),
        ],
      ),
    );
  }

  shoeInfo(width, height) {
    return FadeAnimation(
      delay: 1.5,
      child: SizedBox(
        width: width,
        height: height / 9,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            "A shoe is an item of footwear intended to protect and comfort the human foot. Though the human foot can adapt to varied terrains and climate conditions, it is vulnerable, and shoes provide protection. Form was originally tied to function, but over time, shoes also became fashion items.",
            style: AppThemes.detailsProductDescriptions,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  reviewWidget(width, height) {
    return FadeAnimation(
      delay: 2.5,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ProductReviewsScreen(productId: widget.productModel.id),
            ),
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                AppLocalizations.of(context)!.write_review,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sizeTextAndCountry(width, height) {
    return FadeAnimation(
      delay: 2.5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              AppLocalizations.of(context)!.size,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppConstantsColor.darkTextColor,
                fontSize: 22,
              ),
            ),
          ),
          Expanded(child: Container()),
          SizedBox(
            width: width / 7,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isSelectedCountry = false;
                });
              },
              child: Text(
                "UK",
                style: TextStyle(
                  fontWeight:
                      _isSelectedCountry ? FontWeight.w400 : FontWeight.bold,
                  color:
                      _isSelectedCountry
                          ? Colors.grey
                          : AppConstantsColor.darkTextColor,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width / 5,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isSelectedCountry = true;
                });
              },
              child: Text(
                "USA",
                style: TextStyle(
                  fontWeight:
                      _isSelectedCountry ? FontWeight.bold : FontWeight.w400,
                  color:
                      _isSelectedCountry
                          ? AppConstantsColor.darkTextColor
                          : Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  endSizesAndButton(width, height) {
    return SizedBox(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 3,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            children: [
              Container(
                width: width / 4.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.try_it,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: -1,
                          child: FaIcon(FontAwesomeIcons.shoePrints),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: width / 1.5,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: sizes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelectedSize = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        width: width / 4.4,
                        height: height / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                _isSelectedSize == index
                                    ? Colors.black
                                    : Colors.grey,
                            width: 1.5,
                          ),
                          color:
                              _isSelectedSize == index
                                  ? Colors.black
                                  : AppConstantsColor.backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            sizes[index].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  _isSelectedSize == index
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  materialButton(width, height) {
    return FadeAnimation(
      delay: 3.5,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minWidth: width / 1.2,
        height: height / 15,
        color: AppConstantsColor.materialButtonColor,
        onPressed: () {
          AppMethods.addToCart(widget.productModel, context);
        },
        child: Text(
          AppLocalizations.of(context)!.add_to_cart,
          style: TextStyle(color: AppConstantsColor.lightTextColor),
        ),
      ),
    );
  }
}
