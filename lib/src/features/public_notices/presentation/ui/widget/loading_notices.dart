

import 'package:flutter/material.dart';
import 'package:ministry/src/core/resources/gap_manager.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/shimmers.dart';

class LoadingNotices extends StatelessWidget {
  const LoadingNotices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                commonShimmer(
                    radius: 100,
                    height: 50,
                  width: 50
                ),
                w10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonShimmer(
                      radius: 12,
                      height: 16,
                      width: 120
                    ),
                    h10,
                    commonShimmer(
                        radius: 12,
                        height: 16,
                        width: 200
                    ),
                  ],
                )
              ],
            ),
          ),
          h10,
          Divider(
            color: MyColors.grey,
            endIndent: 16,
            indent: 16,
          ),
          h10,
          Container(
            child: Row(
              children: [
                commonShimmer(
                    radius: 100,
                    height: 50,
                    width: 50
                ),
                w10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonShimmer(
                        radius: 12,
                        height: 16,
                        width: 120
                    ),
                    h10,
                    commonShimmer(
                        radius: 12,
                        height: 16,
                        width: 200
                    ),
                  ],
                )
              ],
            ),
          ),
          h10,
          Divider(
            color: MyColors.grey,
            endIndent: 16,
            indent: 16,
          ),
          h10,
          Container(
            child: Row(
              children: [
                commonShimmer(
                    radius: 100,
                    height: 50,
                    width: 50
                ),
                w10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonShimmer(
                        radius: 12,
                        height: 16,
                        width: 120
                    ),
                    h10,
                    commonShimmer(
                        radius: 12,
                        height: 16,
                        width: 200
                    ),
                  ],
                )
              ],
            ),
          ),
          h10,
          Divider(
            color: MyColors.grey,
            endIndent: 16,
            indent: 16,
          ),
          h10,


        ],
      ),
    );
  }
}
