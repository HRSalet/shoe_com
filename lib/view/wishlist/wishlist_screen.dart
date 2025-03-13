import 'package:flutter/material.dart';
import 'package:sneakers_app/view/wishlist/widget/body.dart';

import '../../utils/constants.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        body: WishlistBodyView(),
      ),
    );
  }
}
