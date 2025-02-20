


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/color_manager.dart';

Shimmer commonShimmer({
  double? height,
  double? radius,
  double? width,
  EdgeInsets? margin,
}){
  return Shimmer.fromColors(
    period: Duration(seconds: 1),
    baseColor: MyColors.grey,
    highlightColor: MyColors.white,
    child: Container(
      height: height,
      margin: margin,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
            color: MyColors.grey
        ),
        color: MyColors.grey,
        borderRadius: BorderRadius.circular(radius ?? 12),
        // color: MyColors.white
      ),
    ),
  );
}