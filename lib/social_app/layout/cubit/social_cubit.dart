import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/social_user_model.dart';
import 'package:udemy_flutter/social_app/modules/chat/chats_screen.dart';
import 'package:udemy_flutter/social_app/modules/feeds/feeds_screen.dart';
import 'package:udemy_flutter/social_app/modules/settings/settings_screen.dart';
import 'package:udemy_flutter/social_app/modules/users/users_screen.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());
  static SocialCubit get(context) => BlocProvider.of<SocialCubit>(context);

  SocialUserModel userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      print(value.id);
      print(value.data());
      userModel = SocialUserModel.fromJson(value.id, value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatssScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> appBarTitles = [
    'News Feeds',
    'Chats',
    'Users',
    'Settings',
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.User,
      ),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  final ImagePicker picker = ImagePicker();
  File profileImage;
  String profileImageUrl = '';

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImageErrorState('No Image Selected'));
    }
  }

  File coverImage;
  String coverImageUrl = '';

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage.path);
      emit(SocialCoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialCoverImageErrorState('No Image Selected'));
    }
  }

  Future<void> uploadProfileImage() async {
    if (profileImage != null) {
      var ref = fireStorage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage.path).pathSegments.last}');
      try {
        await ref.putFile(profileImage);
        String downloadUrl = await ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          profileImageUrl = downloadUrl;
          print("Mine $profileImageUrl");
          emit(SocialProfileImageUploadSuccessState());
        } else {
          emit(SocialProfileImageUploadErrorState(
              'Error wihle uploading profile image'));
        }
      } catch (err) {
        emit(SocialProfileImageUploadErrorState(err.toString()));
      }
    }
    /*await fireStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        print("Mine $profileImageUrl");
        emit(SocialProfileImageUploadSuccessState());
      }).catchError((err) {
        emit(SocialProfileImageUploadErrorState(err.toString()));
      });
    }).catchError((err) {
      emit(SocialProfileImageUploadErrorState(err.toString()));
    });*/
  }

  Future<void> uploadCoverImage() async {
    if (coverImage != null) {
      var ref = fireStorage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage.path).pathSegments.last}');
      try {
        await ref.putFile(coverImage);

        String downloadUrl = await ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          coverImageUrl = downloadUrl;
          print("Mine $coverImageUrl");
          emit(SocialCoverImageUploadSuccessState());
        } else {
          emit(SocialCoverImageUploadErrorState(
              'Error wihle uploading cover image'));
        }
      } catch (err) {
        emit(SocialCoverImageUploadErrorState(err.toString()));
      }
    }
/*
    await fireStorage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        print("Mine $coverImageUrl");
        emit(SocialCoverImageUploadSuccessState());
      }).catchError((err) {
        emit(SocialCoverImageUploadErrorState(err.toString()));
      });
    }).catchError((err) {
      emit(SocialCoverImageUploadErrorState(err.toString()));
    });
    */
  }

  Future<void> updateUser({
    @required String name,
    @required String bio,
    @required String phone,
  }) async {
    emit(SocialUpdateUserLoadingState());
    await uploadProfileImage();
    await uploadCoverImage();
    await updateProfile(phone.trim(), bio.trim(), name.trim());
  }

  Future<void> updateProfile(String phone, String bio, String name) async {
    SocialUserModel model;

    print("Mine  In update $coverImageUrl");
    print("Mine  In update $profileImageUrl");
    model = SocialUserModel(
      email: userModel.email,
      phone: phone,
      bio: bio,
      name: name,
      coverImage:
          coverImageUrl.isNotEmpty ? coverImageUrl : userModel.coverImage,
      image: profileImageUrl.isNotEmpty ? profileImageUrl : userModel.image,
      isEmailVerified: userModel.isEmailVerified,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(model.toJson())
        .then((value) {
      resetImages();
      emit(SocialUpdateUserSuccessState());
      getUserData();
      /*print(value.id);
      print(value.data());
      userModel = SocialUserModel.fromJson(value.id, value.data());*/
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState(error.toString()));
    });
  }

  void resetImages() {
    profileImage = null;
    coverImage = null;
    profileImageUrl = '';
    coverImageUrl = '';
  }
}
