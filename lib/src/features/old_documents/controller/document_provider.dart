


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/utils/toaster.dart';

import '../../../core/resources/color_manager.dart';
import '../../old_reminder/utils/load_state.dart';
import '../domain/model/patient_document_model.dart';
import '../domain/services/patient_document_services.dart';


final patientDocumentNotifier = StateNotifierProvider<PatientDocumentNotifier, LoadState>((ref) {
  return PatientDocumentNotifier(LoadState(
      errorMessage: '',
      isLoad: false,
      isSuccess: false));
});


class PatientDocumentNotifier extends StateNotifier<LoadState> {
  PatientDocumentNotifier(LoadState state) : super(state);


  Future<void> submitDocument(
      {required Map<String,dynamic> data,required String token, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await PatientDocumentServices.addPatientDocuments(data: data,token: token);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

      Toaster.success(r);
      Navigator.pop(context);

    }

    );
  }

  Future<void> delFile(PatientDocumentModel file,{required String token}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await PatientDocumentServices.delPatientDocument(file: file,token: token);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
      Toaster.success(r);
    });
  }


  Future<void> saveDocument(
      {required PatientDocumentModel data,required String token, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await PatientDocumentServices.saveLocalDocuments(data: data,token: token);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

      Toaster.success(r);

    }

    );
  }

  Future<void> delLocalFile(PatientDocumentModel file,{required String token}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await PatientDocumentServices.delLocalDocument(file: file,token: token);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
      Toaster.success(r);
    });
  }


}



final commonProvider = ChangeNotifierProvider.autoDispose((ref) => CommonProvider());

class CommonProvider extends ChangeNotifier {

  int selectedDocumentType = 0;

  bool documentSearch = false;

  String filteredText = '';

  List<String> documentTitles = [];

  int documentType = 0;


  bool isUploading = false;



  void updateDocumentTypeId(int value) {
    selectedDocumentType = value;
    notifyListeners();
  }

  void enableDocumentSearch(bool value) {
    documentSearch = value;
    notifyListeners();
  }


  void searchDocument(String value) {
    filteredText = value;
    notifyListeners();
  }


  void updateDocumentTitles(List<String> value) {
    documentTitles = value;
    notifyListeners();
  }

  void updateDocumentType(int value) {
    documentType = value;
    notifyListeners();
  }


  void updateUploadState(bool value) {
    isUploading = value;
    notifyListeners();
  }



}




final docProvider = StateNotifierProvider.autoDispose<DocProvider, PlatformFile?>((ref) => DocProvider(null));


class DocProvider extends StateNotifier<PlatformFile?>{
  DocProvider(super.state);

  void pickPdf() async{

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf', 'pdx', 'pdfx', 'pdfa', 'pdt', 'pdn'],
    );
    if(result!=null){
      final file = await result.files.first;
      state = file;
    }


  }


}


final docImageProvider = StateNotifierProvider.autoDispose<DocImageProvider, PlatformFile?>((ref) => DocImageProvider(null));


class DocImageProvider extends StateNotifier<PlatformFile?>{
  DocImageProvider(super.state);

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
              lockAspectRatio: false
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      final newImg = XFile(croppedFile!.path);

      File file = File(newImg.path);

      String filePath = file.path;


      // Get the name of the File
      String fileName = file.uri.pathSegments.last;

      // Create a PlatformFile using the path and name
      PlatformFile platformFile = PlatformFile(
          path: filePath,
          name: fileName, size: 128000
      );
      state = platformFile;
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
      final newImg = XFile(croppedFile!.path);
      File file = File(newImg.path);
      String filePath = file.path;
      // Get the name of the File
      String fileName = file.uri.pathSegments.last;

      // Create a PlatformFile using the path and name
      PlatformFile platformFile = PlatformFile(
          path: filePath,
          name: fileName,
          size: 128000
      );
      state = platformFile;
    }
  }
}



