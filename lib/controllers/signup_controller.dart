import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lhw/models/user_model.dart';
import 'package:lhw/repositories/user_repository.dart';
import '../repositories/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final id = TextEditingController();
  final nic = TextEditingController();
  final dob = TextEditingController();
  final password = TextEditingController();
  var isLoading = false.obs;
  final userRepo = Get.put(UserRepository());

  void SignUp(String email, String password) async {
    isLoading.value = true;
    await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
    isLoading.value = false;
  }

  Future<void> createUser(UserModel user) async {
    isLoading.value = true;
    await userRepo.createUser(user);
    isLoading.value = false;
  }

  void Login(String email, String password) {
    AuthenticationRepository.instance
        .LoginUserWithEmailAndPassword(email, password);
  }
  void clearLoginFields() {
    email.clear();
    password.clear();
  }

  void clearSignUpFields() {
    email.clear();
    password.clear();
    name.clear();
    id.clear();
    dob.clear();
    phone.clear();
    nic.clear();
  }




}
