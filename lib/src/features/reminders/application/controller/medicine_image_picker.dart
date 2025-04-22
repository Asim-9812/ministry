






import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/resources/color_manager.dart';



final medImageProvider = StateNotifierProvider<MedImagePicker, XFile?>((ref) => MedImagePicker(null));



class MedImagePicker extends StateNotifier<XFile?>{
  MedImagePicker(super.state);

  void isImage({required File image}) async{
    state = XFile(image.path);
  }

  void pickAnImage() async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: MyColors.primary,
              toolbarWidgetColor: MyColors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      final file = XFile(croppedFile!.path);
      state = file;
    }
  }

  void camera() async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null){
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: MyColors.primary,
              toolbarWidgetColor: MyColors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      final file = XFile(croppedFile!.path);
      state = file;
    }



  }

}


