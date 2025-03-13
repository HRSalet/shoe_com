import 'package:flutter/material.dart';
import 'package:sneakers_app/models/shoe_model.dart';
import 'package:sneakers_app/view/detail/components/app_bar.dart';
import 'package:sneakers_app/view/detail/components/body.dart';

import '../../utils/constants.dart';

class DetailScreen extends StatelessWidget {
  final ShoeModel model;
  final bool isComeFromMoreSection;

  DetailScreen({required this.model, required this.isComeFromMoreSection});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppConstantsColor.backgroundColor,
        appBar: customAppBarDe(
          context,
          model.name, // Pass brand name
          model, // Pass shoe model to update wishlist
        ),
        body: DetailsBody(
          model: model,
          isComeFromMoreSection: isComeFromMoreSection,
        ),
      ),
    );
  }
}
