

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../application/bmr_controllers/bmr_controller.dart';
import '../../../../../application/height_converter.dart';



class BmrSlider extends ConsumerWidget {
  const BmrSlider({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final height = ref.watch(bmrController).height;

    return SfSlider.vertical(
      activeColor: MyColors.primary,
      inactiveColor: MyColors.grey,
      // Minimum and maximum heights of avg person for bmi to matter.
      min: 91.44,
      max: 243.84,
      value: height,
      interval: 30.48,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      onChanged: (val){
        ref.read(bmrController.notifier).updateHeight(val);
      },
      labelFormatterCallback: (actualVal, formattedText) {
        final unit = ref.watch(bmrController).unitIndex; // another state watch is necessary for slider update
        return unit == 0
            ? '${actualVal.round()}'
            : '${convertCmToFeetAndInches(actualVal).$1}';
      },
      tooltipPosition: SliderTooltipPosition.left,
      tooltipTextFormatterCallback: (actualVal, formattedText) {
        final unit = ref.watch(bmrController).unitIndex; // another state watch is necessary for slider update
        return unit == 0
            ? '${actualVal.round()} cm'
            : '${convertCmToFeetAndInches(actualVal).$1} ft';
      },

    );
  }
}
