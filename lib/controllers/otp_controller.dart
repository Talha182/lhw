

import 'package:get/get.dart';
import 'package:lhw/authentication_repository/authentication_repository.dart';
import 'package:lhw/navy.dart';


class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => Custom_NavBar()) : Get.back();

}
}