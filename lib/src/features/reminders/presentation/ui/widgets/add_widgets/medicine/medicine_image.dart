



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/resources/gap_manager.dart';
import '../../../../../application/controller/medicine_image_picker.dart';

class MedicineImage extends ConsumerWidget {
  const MedicineImage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final image = ref.watch(medImageProvider);
    final imagePath = image == null ? '' : path.basename(image.path);
    return InkWell(
      onTap: () async {

        await showModalBottomSheet(context: context, builder: (context){
          return Container(
            color: MyColors.white,
            constraints: BoxConstraints(
                minHeight: 150
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      ref.read(medImageProvider.notifier).camera();
                      Navigator.pop(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.lightGrey,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt,color: MyColors.primary,),
                          Text('Camera',style: br3,)
                        ],
                      ),
                    ),
                  ),
                ),
                w10,
                Expanded(
                  child: InkWell(
                    onTap: (){
                      ref.read(medImageProvider.notifier).pickAnImage();
                      Navigator.pop(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.lightGrey,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image,color: MyColors.primary,),
                          Text('Gallery',style: br3,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });



      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: MyColors.primary
            )
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(FontAwesomeIcons.image,size: 16,color: MyColors.primary,),
                  w18,
                  Text(image == null
                      ? 'Provide an medicine image (optional)'
                      : imagePath, style: bh3,maxLines: 1,)
                ],
              ),
            ),
            if(image != null)
              InkWell(
                  onTap: (){
                    ref.invalidate(medImageProvider);
                  },
                  child: Icon(Icons.close,color: MyColors.red,size: 16,))
          ],
        ),
      ),
    );
  }
}
