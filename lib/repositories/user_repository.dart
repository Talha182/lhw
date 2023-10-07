  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:get/get.dart';
  import 'package:lhw/models/user_model.dart';

  class UserRepository extends GetxController {
    static UserRepository get instance => Get.find();

    final _db = FirebaseFirestore.instance;

    createUser(UserModel user) async {
      await _db
          .collection("Users")
          .add(user.toJson())
          .whenComplete(() => Fluttertoast.showToast(
              msg: "Your account has been created",
              backgroundColor: Colors.green.withOpacity(0.1),
              textColor: Colors.green))
          .catchError((error) {
        Get.snackbar("Error", "Something went wrong. Try Again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.redAccent);
        print(error.toString());
        throw Exception('Failed to create user');
      });
    }

    // For fetching single record
    Future<UserModel> getUserDetails(String email) async {
      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    }

    Future<List<UserModel>> allUser() async {
      final snapshot =
          await _db.collection("Users").get();
      final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return userData;
    }

    Future<void> updateUserRecord(UserModel user) async{
      await _db.collection("Users").doc(user.id).update(user.toJson());
    }

  }
