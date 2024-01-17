import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nibbles_ecommerce/configs/configs.dart';
import 'package:nibbles_ecommerce/models/models.dart';
import 'package:nibbles_ecommerce/presentation/widgets.dart';
import 'dart:math' as math;

import '../../core/core.dart';

class KidProfileScreen extends StatelessWidget {
  const KidProfileScreen({super.key, required this.kid});

  final Kid kid;

  @override
  Widget build(BuildContext context) {
    final random = math.Random();

    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: Space.hf(1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.y!,
            Text(
              "KID Profile".toUpperCase(),
              style: AppText.h2b,
            ),
            Space.y1!,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppAssets.kidsImages[random.nextInt(2)],
                ),
                Space.xf(),
                Text(
                  kid.name.capitalize(),
                  style: AppText.h3,
                ),
                Space.xf(2),
                editSvg(),
                Space.xf(.5),
                Image.asset(
                  AppAssets.removePng,
                  height: AppDimensions.normalize(18),
                )
              ],
            ),
            Space.y2!,
            Text(
              "Personal Details",
              style: AppText.h2,
            ),
            Space.y!,
            Wrap(

              children: [
               
              ],
            )
          ],
        ),
      ),
    );
  }
}
