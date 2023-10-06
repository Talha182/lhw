class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? nic;
  final String? phoneNo;
  final String? password;
  final String? dob;

  const UserModel(
    this.id,
    this.name,
    this.email,
    this.nic,
    this.phoneNo,
    this.password,
    this.dob,
  );
  toJson() {
    return {
      "Id": id,
      "Name": name,
      "Email": email,
      "Nic": nic,
      "Phone": phoneNo,
      "Password": password,
      "dob": dob,
    };
  }
}
