import 'dart:io';

import 'package:chat_app/presentation/screen/chats_screen.dart';
import 'package:chat_app/presentation/screen/home_screen.dart';
import 'package:chat_app/presentation/screen/profile_screen.dart';
import 'package:chat_app/shared_component/preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/models.dart';
import '../../presentation/screen/add_post_screen.dart';
import '../../presentation/screen/users_screen.dart';
import '../../shared_component/di.dart';

part 'social_home_state.dart';

class SocialMainCubit extends Cubit<SocialMainState> {
  SocialMainCubit() : super(SocialMainInitial());
  UserModel? userModel;
  void getUserData() async {
    emit(SocialMainLoadingState());
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(uidValue)
          .get();
      //print(documentSnapshot.data());
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      //print(userModel!.username);
      emit(SocialMainSuccessState(userModel!));
    } catch (error) {
      emit(SocialMainFailureState(error.toString()));
    }
  }

  AppPreferences appPreferences = instance();

  Future<void> onSignOut() async {
    uidValue = null;
    appPreferences.setUid("");
    emit(SocialSignOutState());
    await FirebaseAuth.instance.signOut();
  }

  List<Widget> widgets = [
    const HomeScreen(),
    const ChatScreen(),
    const AddPostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = ["Home", "Chats", "Add Post", "Users", "Profile"];
  int currentIndex = 0;
  void changeCurrentIndex(int ind) {
    if (ind == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = ind;
      emit(SocialMainChangeState());
    }
  }

  final ImagePicker picker = ImagePicker();
  File? profileImage;
  Future<void> getProfileImage() async {
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No image selected..!");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = File(image.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("No image selected..!");
      emit(SocialCoverImagePickedErrorState());
    }
  }
}
