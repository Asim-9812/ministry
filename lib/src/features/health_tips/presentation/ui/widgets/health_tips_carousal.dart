
import 'package:ministry/src/core/resources/gap_manager.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/features/health_tips/application/controller/health_tips_carousal_controller.dart';
import 'package:ministry/src/features/health_tips/application/providers/health_tips_providers.dart';
import 'package:ministry/src/features/health_tips/presentation/ui/widgets/detailed_tips_dialog.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/features/banners/application/providers/banner_providers.dart';
import 'package:ministry/src/features/banners/presentation/ui/widgets/no_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../../core/resources/font_manager.dart';



class HealthTipsCarousal extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthTipsAsyncValue = ref.watch(healthTipsProvider);
    final highlightIndex = ref.watch(healthTipsCarousalController).carousalIndex;
    final baseUrl = Api.baseUrl;

    return healthTipsAsyncValue.when(
      data: (healthTips) {
        int list = healthTips.length;
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 160,
                // enlargeCenterPage: true,
                // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 9),
                autoPlayAnimationDuration: Duration(milliseconds: 500),
                viewportFraction: 1,
                onPageChanged: (index,reason){
                  ref.read(healthTipsCarousalController.notifier).changeIndex(index);
                }
              ),
              items: healthTips.map((healthTip) {
                return Card(

                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: MyColors.grey
                      ),
                      color: MyColors.primaryLight
                    ),

                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 10,
                          left: 200,
                          top: 120,
                          child: CircleAvatar(
                            backgroundColor: MyColors.primary.withAlpha(100),
                            radius: 40,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 10,
                          left: 300,
                          top: 100,
                          child: CircleAvatar(
                            backgroundColor: MyColors.primary.withAlpha(75),
                            radius: 40,
                          ),
                        ),
                        Positioned(
                          right: -70,
                          bottom: 60,
                          left: 180,
                          top: 10,
                          child: CircleAvatar(
                            backgroundColor: MyColors.primary.withAlpha(50),
                            radius: 40,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Health Tips',style: bh3,maxLines: 1,),
                                h10,
                                Text(healthTip.title,style: bh1,maxLines: 1,),
                                h10,
                                Text(healthTip.shortInfo,style: br1,maxLines: 1,),
                                h20,
                                HealthTipDialog(healthTip: healthTip)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(list, (index){
                return Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: highlightIndex == index ? MyColors.primary : MyColors.grey,
                  ),
                  padding: EdgeInsets.all(4),
                );
              }),
            )
          ],
        );
      },
      loading: () => commonShimmer(
        height: 160,
        radius: 0,
        // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      ),
      error: (err, stack) => SizedBox(),
    );
  }
}
