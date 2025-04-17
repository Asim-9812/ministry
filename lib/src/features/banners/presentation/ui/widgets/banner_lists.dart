
import 'dart:convert';
import 'dart:typed_data';

import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/banners/application/providers/banner_providers.dart';
import 'package:ministry/src/features/banners/presentation/ui/widgets/no_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';



class BannerLists extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAsyncValue = ref.watch(bannerProviders);
    final baseUrl = Api.baseUrl;

    return bannerAsyncValue.when(
      data: (banners) {
        if(banners.isEmpty){
          return NoBanner();
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 160,
            // enlargeCenterPage: true,
            aspectRatio: 16/9,
            // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(seconds: 1),
            viewportFraction: 1,
          ),
          items: banners.map((banner) {
            final bannerImg = banner.imagePath.split(',').last;
            Uint8List imageBytes = base64Decode(bannerImg);
            return Builder(
              builder: (BuildContext context) {
                return Card(
                  color: MyColors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.grey
                      ),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(image: MemoryImage(imageBytes),fit: BoxFit.fill),
                      // color: MyColors.white
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
      loading: () => commonShimmer(
        height: 140,
        radius: 12,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      ),
      error: (err, stack) => NoBanner(),
    );
  }
}
