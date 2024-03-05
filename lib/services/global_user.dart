import '../models/user_model.dart'; // Make sure to replace 'your_project' with your actual project path

class GlobalUser {
  static final GlobalUser _instance = GlobalUser._internal();

  User? _currentUser;

  factory GlobalUser() {
    return _instance;
  }

  GlobalUser._internal();

  static void updateUser(User user) {
    _instance._currentUser = user;
  }

  static void clearUser() {
    _instance._currentUser = null;
  }

  static User? get getCurrentUser => _instance._currentUser;
}
