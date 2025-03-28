import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/custom_app_theme.dart';
import '../../../utils/constants.dart';

PreferredSize? customAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text("Discover", style: AppThemes.homeAppBar),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: IconButton(
            icon: FaIcon(
              CupertinoIcons.search,
              color: AppConstantsColor.darkTextColor,
              size: 25,
            ),
            onPressed: () {
              //showSearch(context: context, delegate: ShoeSearchDelegate());
            },
          ),
        ),
      ],
    ),
  );
}
