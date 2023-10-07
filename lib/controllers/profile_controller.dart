import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lhw/models/user_model.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:lhw/repositories/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  //Controllers
  final name = TextEditingController();
  final dob = TextEditingController();
  final phoneNo = TextEditingController();
  final id = TextEditingController();
  final email = TextEditingController();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login To Continue");
    }
  }
  /// Fetch list of user records
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUser();

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }

}
