


import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/toaster.dart';
import '../../../utils/load_state.dart';
import '../domain/model/medicine_model.dart';
import '../domain/services/medicine_services.dart';




final medicineReminderNotifier = StateNotifierProvider<MedicineReminderNotifier, LoadState>((ref) {
  return MedicineReminderNotifier(LoadState(
      errorMessage: '',
      isLoad: false,
      isSuccess: false));
});


class MedicineReminderNotifier extends StateNotifier<LoadState> {
  MedicineReminderNotifier(LoadState state) : super(state);


  Future<void> addReminder(
      {required MedicineModel medicineModel, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await MedicineServices.addMedicine(medicine: medicineModel);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

      Toaster.success(r);
      Navigator.pop(context);
      Navigator.pop(context);

    }

    );
  }


  Future<void> editReminder(
      {required MedicineModel medicineModel, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await MedicineServices.editMedicine(medicine: medicineModel);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

      Toaster.success(r);
      Navigator.pop(context);
      Navigator.pop(context);

    }

    );
  }

  Future<void> delReminder(MedicineModel medicineModel) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await MedicineServices.delMedicine(medicine: medicineModel);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
      Toaster.success(r);
    });
  }


}