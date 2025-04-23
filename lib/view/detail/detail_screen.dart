import 'package:flutter/material.dart';
import 'package:sneakers_app/models/shoe_model.dart';
import 'package:sneakers_app/view/detail/components/body.dart';

import '../../utils/constants.dart';

class DetailScreen extends StatelessWidget {
  final Product productModel;
  final bool isComeFromMoreSection;

  DetailScreen({
    required this.productModel,
    required this.isComeFromMoreSection,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        body: DetailsBody(
          productModel: productModel,
          isComeFromMoreSection: isComeFromMoreSection,
        ),
      ),
    );
  }
}
