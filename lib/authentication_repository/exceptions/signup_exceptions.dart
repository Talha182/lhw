class SignUpExceptions {
  final String message;

  const SignUpExceptions({this.message = "An Unknown Error Occured"});

  factory SignUpExceptions.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpExceptions(
            message: 'Please enter a stronger password');
      case 'invalid-email':
        return const SignUpExceptions(
            message: 'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignUpExceptions(
            message: "An account already exists for that email");
      case 'operation-not-allowed':
        return const SignUpExceptions(
            message: "Operation is not allowed. Please contact support");
      case 'user-disable':
        return const SignUpExceptions(
            message: "The user has been disabled please contact for help");
      default:
        return const SignUpExceptions();
    }
  }
}
