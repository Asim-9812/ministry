

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../application/bmi_controllers/bmi_controller.dart';
import '../../../../../application/height_converter.dart';



class BmiSlider extends ConsumerWidget {
  const BmiSlider({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final height = ref.watch(bmiController).height;

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
        ref.read(bmiController.notifier).updateHeight(val);
      },
      labelFormatterCallback: (actualVal, formattedText) {
        final unit = ref.watch(bmiController).unitIndex; // another state watch is necessary for slider update
        return unit == 0
            ? '${actualVal.round()}'
            : '${convertCmToFeetAndInches(actualVal).$1}';
      },
      tooltipPosition: SliderTooltipPosition.left,
      tooltipTextFormatterCallback: (actualVal, formattedText) {
        final unit = ref.watch(bmiController).unitIndex; // another state watch is necessary for slider update
        return unit == 0
            ? '${actualVal.round()} cm'
            : '${convertCmToFeetAndInches(actualVal).$1} ft';
      },

    );
  }
}
