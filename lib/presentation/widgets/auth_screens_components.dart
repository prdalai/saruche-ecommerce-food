import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nibbles_ecommerce/presentation/widgets.dart';

import '../../configs/configs.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

Widget authTopColumn(bool isFromSignUp) {
  return Column(
    children: [
      SvgPicture.asset(
        AppAssets.logoRuby,
        width: AppDimensions.normalize(65),
        colorFilter:
            const ColorFilter.mode(AppColors.antiqueRuby, BlendMode.srcIn),
      ),
      Text(
        isFromSignUp ? "SIGN UP" : "SIGN IN",
        style: AppText.h2b,
      ),
      Space.yf(2.5),
    ],
  );
}

Widget authBottomButton(bool isFromSignUp, void Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: AppDimensions.normalize(35),
      decoration: BoxDecoration(
          color: AppColors.antiqueRuby,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.normalize(7.5)),
              topRight: Radius.circular(AppDimensions.normalize(7.5)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isFromSignUp
                ? "Already have an account?"
                : "Don’t have an account?",
            style: AppText.b2?.copyWith(color: Colors.white),
          ),
          Space.yf(.5),
          Text(
            isFromSignUp ? "Login".toUpperCase() : "SIGN UP",
            style: AppText.h3b?.copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
