
import 'package:get/get.dart';
import 'package:lhw/repositories/authentication_repository/authentication_repository.dart';
import 'package:lhw/repositories/user_repository.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  getUserData(){
    final email = _authRepo.firebaseUser.value?.email;
    if(email!=null){
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login To Continue");
    }

}
}