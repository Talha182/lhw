import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  final int id;
  final String name;
  final String email;
  final String phone;
  final String nic;
  final String idNo;
  final String dob;
  final String village;
  final String ucName;
  final int yearsExperience;
  final String? emailVerifiedAt;
  final String password;
  final String image;
  final int? roleId;
  final String status;
  final String? rememberToken;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nic,
    required this.idNo,
    required this.dob,
    required this.village,
    required this.ucName,
    required this.yearsExperience,
    this.emailVerifiedAt,
    required this.password,
    required this.image,
    this.roleId,
    required this.status,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a User instance into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'nic': nic,
      'idNo': idNo,
      'dob': dob,
      'village': village,
      'ucName': ucName,
      'yearsExperience': yearsExperience,
      'emailVerifiedAt': emailVerifiedAt,
      'password': password,
      'image': image,
      'roleId': roleId,
      'status': status,
      'rememberToken': rememberToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Convert a Map into a User instance. Assumes the map was created by this class's
  // toJson method.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      nic: json['nic'],
      idNo: json['idNo'],
      dob: json['dob'],
      village: json['village'],
      ucName: json['ucName'],
      yearsExperience: json['yearsExperience'],
      emailVerifiedAt: json['emailVerifiedAt'],
      password: json['password'],
      image: json['image'],
      roleId: json['roleId'],
      status: json['status'],
      rememberToken: json['rememberToken'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
