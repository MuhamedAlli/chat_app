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
import 'package:firebase_storage/firebase_storage.dart';
part 'social_home_state.dart';

class SocialMainCubit extends Cubit<SocialMainState> {
  SocialMainCubit() : super(SocialMainInitial());
  UserModel? userModel;
  Future<void> getUserData() async {
    emit(SocialMainLoadingState());
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(uidValue)
          .get();
      //print(documentSnapshot.data());
      userModel =
          UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      //print(userModel!.uid);
      emit(SocialMainSuccessState(userModel!));
    } catch (error) {
      emit(SocialMainFailureState(error.toString()));
    }
  }

//get All users
  List<UserModel> allUsers = [];
  Future<void> getAllUser() async {
    allUsers = [];
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        //print(element.data());
        if (element.data()['uid'] != userModel!.uid) {
          allUsers.add(UserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
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
    AddPostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = ["Home", "Chats", "Add Post", "Users", "Profile"];
  int currentIndex = 0;
  void changeCurrentIndex(int ind) async {
    //getUserData();
    if (ind == 1) {
      await getAllUser();
    }

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
      //print("No image selected..!");
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
      //print("No image selected..!");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  Future<String> uplaodProfileImage() async {
    try {
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
          .putFile(profileImage!);
      profileImageUrl = await taskSnapshot.ref.getDownloadURL();
      //print(profileImageUrl);
      emit(SocialUploadProfileImageSuccessState());
      return profileImageUrl;
    } catch (error) {
      emit(SocialUploadProfileImageErrorState());
      return userModel!.image!;
    }
  }

  String coverImageUrl = '';
  Future<String> uplaodCoverImage() async {
    try {
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
          .putFile(coverImage!);
      coverImageUrl = await taskSnapshot.ref.getDownloadURL();
      //print(coverImageUrl);
      emit(SocialUploadCoverImageSuccessState());
      return coverImageUrl;
    } catch (error) {
      emit(SocialUploadCoverImageErrorState());
      return userModel!.cover!;
    }
  }

  void updateUserData(String username, String bio, String phone) async {
    emit(SocialLoadingUpdateUserDataState());
    if (coverImage != null && profileImage != null) {
      profileImageUrl = await uplaodProfileImage();
      coverImageUrl = await uplaodCoverImage();
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel!.uid)
          .update({
        "image": profileImageUrl,
        "cover": coverImageUrl,
        "bio": bio,
        "username": username,
        "phone": phone
      }).then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDataErroeState());
      });
    } else if (coverImage != null) {
      coverImageUrl = await uplaodCoverImage();
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel!.uid)
          .update({
        "cover": coverImageUrl,
      }).then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDataErroeState());
      });
    } else if (profileImage != null) {
      profileImageUrl = await uplaodProfileImage();
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel!.uid)
          .update({
        "image": profileImageUrl,
      }).then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDataErroeState());
      });
    } else {
      FirebaseFirestore.instance.collection("users").doc(userModel!.uid).update(
          {"bio": bio, "username": username, "phone": phone}).then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserDataErroeState());
      });
    }
  }

  //create post with image and without image

  File? postImage;
  Future<void> getPostImage() async {
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = File(image.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      //print("No image selected..!");
      emit(SocialPostImagePickedErrorState());
    }
  }

  String postImageUrl = '';
  Future<String> uplaodPostImage() async {
    try {
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
          .putFile(postImage!);
      postImageUrl = await taskSnapshot.ref.getDownloadURL();
      //print(postImageUrl);
      emit(SocialUploadPostImageSuccessState());
      return postImageUrl;
    } catch (error) {
      emit(SocialUploadPostImageErrorState());
      return "";
    }
  }

  void removePostImgae() {
    postImage = null;
    emit(SocialRemovePostImagePickedErrorState());
  }

  void createPost(String postBody, String dateTime, String username, String uid,
      String image) async {
    emit(SocialLoadingCreatePostState());

    if (postImage != null) {
      String postImageUrl = await uplaodPostImage();
      PostModel postModel = PostModel(
          username: userModel!.username ?? "",
          uid: userModel!.uid ?? "",
          image: userModel!.image ?? "",
          dateTime: dateTime,
          text: postBody,
          postImage: postImageUrl);

      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    } else {
      PostModel postModel = PostModel(
          username: userModel!.username ?? "",
          uid: userModel!.uid ?? "",
          image: userModel!.image ?? "",
          dateTime: dateTime,
          text: postBody,
          postImage: postImageUrl);

      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }
  }

  List<PostModel> posts = [];

  List<String> postId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error));
    });
  }

  void sendMessage(String receiverId, String dateTime, String text) {
    getUserData();
    MessageModel messageModel = MessageModel(
        senderId: userModel!.uid,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
//send message to sender database
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      //emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      //emit(SocialSendMessageErrorState());
    });
//send message to receiver database
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      value.id;
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  String id = '';
  List<MessageModel> messages = [];
  void getMessages(String receiverId) async {
    //print("uId of me ::  ${userModel!.uid}");
    await getUserData();
    if (userModel != null) {
      id = userModel!.uid!;
    }
    //print(id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      //print(event.docs.length);
      messages = [];
      event.docs.forEach(
        (element) {
          messages.add(MessageModel.fromJson(element.data()));
        },
      );
      emit(SocialGetMessageSuccessState(messages));
      //print("From Cubit ${messages.length}");

      emit(SocialGetMessageSuccessState(messages));
      //print("From Cubit ${messages.length}");
    });
  }
}
