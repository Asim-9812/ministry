


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/status_page/domain/model/user_model.dart';

final userInfoProvider = StateProvider((ref) => UserInfoProvider.getCurrentUserInfo());


class UserInfoProvider extends StateNotifier{
  UserInfoProvider(super.state);




  static UserModel? getCurrentUserInfo() {

    final userBox = Hive.box<UserModel>('users');
    final user = userBox.get('user');

    return user;
  }

}