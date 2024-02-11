import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lhw/models/user_model.dart';
import 'package:lhw/repositories/user_repository.dart';
import 'package:lhw/splash/splash.dart';
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
  var isLoading = false.obs;


  Future<void> RegisterUser(String email, String password) async {
    try {
      isLoading.value = true;
      // First, try to authenticate the user
      String? error = await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, password) as String?;

      // If authentication is successful, save the user details to Firestore
      if (error == null) {
        final user = UserModel(
            id.text.trim(),
            name.text.trim(),
            email.trim(),
            nic.text.trim(),
            phoneNo.text.trim(),
            password.trim(),
            dob.text.trim());

        await createUser(user);
        Get.offAll(() => const SplashScreen()); // Redirect to splash screen or wherever you want to redirect after successful registration
      } else {
        // If authentication fails, show error message
        Get.showSnackbar(GetSnackBar(message: error.toString()));
      }
    } finally {
      isLoading.value = false; // Stop loading after the operation completes, either successfully or with an error
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
