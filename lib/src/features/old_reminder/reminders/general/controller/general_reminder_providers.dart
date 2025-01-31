






import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/load_state.dart';
import '../../../../../core/utils/toaster.dart';
import '../domain/model/general_model.dart';
import '../domain/services/general_services.dart';




final generalReminderNotifier = StateNotifierProvider<GeneralReminderNotifier, LoadState>((ref) {
  return GeneralReminderNotifier(LoadState(
      errorMessage: '',
      isLoad: false,
      isSuccess: false));
});


class GeneralReminderNotifier extends StateNotifier<LoadState> {
  GeneralReminderNotifier(LoadState state) : super(state);


  Future<void> addReminder(
      {required GeneralModel generalModel, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await GeneralReminderServices.addGeneral(general: generalModel);
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
      {required GeneralModel generalModel, required BuildContext context}) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await GeneralReminderServices.editGeneral(general: generalModel);
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

  Future<void> delReminder(GeneralModel generalModel) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await GeneralReminderServices.delGeneral(general: generalModel);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
      Toaster.error(l);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
      Toaster.success(r);
    });
  }


}