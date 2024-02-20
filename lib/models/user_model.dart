import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String phone;
  String nic;
  String idNo;
  String dob;
  String village;
  String ucName;
  int yearsExperience;
  String? emailVerifiedAt; // Already nullable, no default needed
  String password;
  String image;
  int? roleId; // Already nullable, no default needed
  String status;
  String? rememberToken; // Already nullable, no default needed
  String createdAt;
  String updatedAt;

  User({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.nic = '',
    this.idNo = '',
    this.dob = '',
    this.village = '',
    this.ucName = '',
    this.yearsExperience = 0,
    this.emailVerifiedAt, // Nullable, defaults to null
    this.password = '',
    this.image = '',
    this.roleId, // Nullable, defaults to null
    this.status = '',
    this.rememberToken, // Nullable, defaults to null
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      nic: json['nic'] as String? ?? '',
      idNo: json['id_no'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      village: json['village'] as String? ?? '',
      ucName: json['uc_name'] as String? ?? '',
      yearsExperience: json['years_experience'] as int? ?? 0,
      emailVerifiedAt: json['email_verified_at'] as String?,
      password: json['password'] as String? ?? '',
      image: json['image'] as String? ?? '',
      roleId: json['role_id'] as int?,
      status: json['status'] as String? ?? '',
      rememberToken: json['remember_token'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'nic': nic,
      'id_no': idNo,
      'dob': dob,
      'village': village,
      'uc_name': ucName,
      'years_experience': yearsExperience,
      'email_verified_at': emailVerifiedAt,
      'password': password,
      'image': image,
      'role_id': roleId,
      'status': status,
      'remember_token': rememberToken,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
class UserCourseProgress {
  int userId;
  int courseId;
  double courseProgress;
  Map<int, double> moduleProgress; // Maps moduleId to progress

  UserCourseProgress({
    required this.userId,
    required this.courseId,
    this.courseProgress = 0.0,
    Map<int, double>? moduleProgress,
  }) : moduleProgress = moduleProgress ?? {};

// Add methods to update progress, e.g., updateModuleProgress, updateCourseProgress
}
