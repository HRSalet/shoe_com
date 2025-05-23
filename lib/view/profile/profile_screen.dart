import 'package:flutter/material.dart';
import 'package:sneakers_app/utils/constants.dart';
import 'package:sneakers_app/view/profile/widget/body.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstantsColor.backgroundColor,
        body: ProfileBody(),
      ),
    );
  }
}
