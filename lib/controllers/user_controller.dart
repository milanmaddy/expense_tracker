import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_tigada/models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> currentUser = UserModel(
    id: '1',
    name: 'Maddy',
    profileUrl: "https://avatar.iran.liara.run/public/48",
    email: 'areyoucrazyy@gmail.com',
    phoneNumber: '+91 7586960740',
  ).obs;

  final RxList<UserModel> roommates = <UserModel>[].obs;

  /// Static profile image options
  final List<String> profileOptions = [
    "https://avatar.iran.liara.run/public/48",
    "https://avatar.iran.liara.run/public/15",
    "https://avatar.iran.liara.run/public/16",
    "https://avatar.iran.liara.run/public/17",
    "https://avatar.iran.liara.run/public/18",
  ];

  @override
  void onInit() {
    super.onInit();
    roommates.addAll([
      UserModel(
        id: '1',
        name: 'Maddy',
        email: 'areyoucrazyy@gmail.com',
        phoneNumber: '+91 7586960740',
        profileUrl: "https://avatar.iran.liara.run/public/48",
      ),
      UserModel(
        id: '2',
        name: 'Rishav',
        profileUrl: "https://avatar.iran.liara.run/public/15",
      ),
      UserModel(
        id: '3',
        name: 'Shovan',
        profileUrl: "https://avatar.iran.liara.run/public/16",
      ),
    ]);
  }

  // void updateProfilePicture(String url) {
  //   currentUser.update((user) {
  //     if (user != null) {
  //       user.profileUrl = url;
  //     }
  //   });
  // }
}