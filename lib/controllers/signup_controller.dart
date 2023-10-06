

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lhw/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final id = TextEditingController();
  final nic = TextEditingController();
  final dob = TextEditingController();
  final password = TextEditingController();

  void SignUp(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  void phoneAuthentication(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }


}