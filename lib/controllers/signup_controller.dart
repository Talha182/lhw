import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lhw/models/user_model.dart';
import 'package:lhw/repositories/user_repository.dart';
import '../repositories/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final phoneNo = TextEditingController();
  final email = TextEditingController();
  final id = TextEditingController();
  final nic = TextEditingController();
  final dob = TextEditingController();
  final password = TextEditingController();
  final userRepo = Get.put(UserRepository());

  Future<bool> SignUp(String email, String password) async {
    try {
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      print("Error while signing up: $e");
      return false;
    }
  }


  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
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
    phoneNo.clear();
    nic.clear();
  }




}
