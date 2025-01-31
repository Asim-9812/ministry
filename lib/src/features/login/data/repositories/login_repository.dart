



import '../../../status_page/domain/model/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> login({required String username, required String password});
}
