

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resources/color_manager.dart';

final imageProvider = StateNotifierProvider.autoDispose<ImageProvider, XFile?>((ref) => ImageProvider(null));



class ImageProvider extends StateNotifier<XFile?>{
  ImageProvider(super.state);

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




final imageListProvider = StateNotifierProvider<ImageListProvider, List<XFile>?>((ref) => ImageListProvider(null));



class ImageListProvider extends StateNotifier<List<XFile>?>{
  ImageListProvider(super.state);


  void isImageList({required List<File> image}) async{

    List<XFile> tempList = [];

    for(var i in image){
      final img = XFile(i.path);
      tempList.add(img);
    }

    state = tempList;
  }


  void pickMultipleImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickMultiImage();

    // print(image.length);

    state =state==null? image : [...state!,...image];

  }

  void camera() async{
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    if(image != null){
      final tempList = [image];
      state =state==null? tempList : [...state!,...tempList];
    }



  }

  void deleteImage({required int index}) {
    if(state !=null){
      if(state!.length == 1){
        state = null;
      }
      else{
        final tempList = state!;
        tempList.removeAt(index);

        state = [...tempList];
      }

    }

  }

}

