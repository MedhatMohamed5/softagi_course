import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/social_app/layout/cubit/chats_states.dart';
import 'package:udemy_flutter/social_app/layout/cubit/new_post_states.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/chat_message_model.dart';
import 'package:udemy_flutter/social_app/models/post_model.dart';
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

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print(value.id);
      print(value.data());
      userModel = SocialUserModel.fromJson(value.id, value.data()!);
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
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  final ImagePicker picker = ImagePicker();
  File? profileImage;
  String profileImageUrl = '';

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage!.path);
      emit(SocialProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialProfileImageErrorState('No Image Selected'));
    }
  }

  File? coverImage;
  String coverImageUrl = '';

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage!.path);
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
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}');
      try {
        await ref.putFile(profileImage!);
        String downloadUrl = await ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          profileImageUrl = downloadUrl;
          print("Mine $profileImageUrl");
          emit(SocialProfileImageUploadSuccessState());
          emit(CreatePostLodingState());
        } else {
          emit(SocialProfileImageUploadErrorState(
              'Error wihle uploading profile image'));
        }
      } catch (err) {
        emit(SocialProfileImageUploadErrorState(err.toString()));
      }
    }
  }

  Future<void> uploadCoverImage() async {
    if (coverImage != null) {
      var ref = fireStorage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}');
      try {
        await ref.putFile(coverImage!);

        String downloadUrl = await ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          coverImageUrl = downloadUrl;
          print("Mine $coverImageUrl");
          emit(SocialCoverImageUploadSuccessState());
          emit(CreatePostLodingState());
        } else {
          emit(SocialCoverImageUploadErrorState(
              'Error wihle uploading cover image'));
        }
      } catch (err) {
        emit(SocialCoverImageUploadErrorState(err.toString()));
      }
    }
  }

  Future<void> updateUser({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(SocialUpdateUserLoadingState());
    await uploadProfileImage();
    await uploadCoverImage();
    await updateProfile(phone.trim(), bio.trim(), name.trim());
  }

  Future<void> updateProfile(String phone, String bio, String name) async {
    emit(CreatePostLodingState());
    SocialUserModel model;

    print("Mine  In update $coverImageUrl");
    print("Mine  In update $profileImageUrl");
    model = SocialUserModel(
      email: userModel!.email,
      phone: phone,
      bio: bio,
      name: name,
      coverImage:
          coverImageUrl.isNotEmpty ? coverImageUrl : userModel!.coverImage,
      image: profileImageUrl.isNotEmpty ? profileImageUrl : userModel!.image,
      isEmailVerified: userModel!.isEmailVerified,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

  Future<void> createNewPost({required PostModel post}) async {
    emit(CreatePostLodingState());
    await uploadPostImage();

    post.postImage = postImageUrl;
    print("Post --- ${post.toJson().toString()}");

    await FirebaseFirestore.instance
        .collection('posts')
        .add(post.toJson())
        .then((value) {
      postImage = null;
      postImageUrl = '';
      emit(CreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState(error.toString()));
    });
  }

  File? postImage;
  String postImageUrl = '';

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage!.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialPostImageErrorState('No Image Selected'));
    }
  }

  void removePostImage() {
    postImage = null;
    postImageUrl = '';
    emit(SocialPostImageRemoveState());
  }

  Future<void> uploadPostImage() async {
    if (postImage != null) {
      var ref = fireStorage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}');
      try {
        await ref.putFile(postImage!);
        String downloadUrl = await ref.getDownloadURL();
        if (downloadUrl.isNotEmpty) {
          postImageUrl = downloadUrl;
          print("Mine $postImageUrl");
          emit(SocialPostImageUploadSuccessState());
          emit(CreatePostLodingState());
        } else {
          emit(SocialPostImageUploadErrorState(
              'Error wihle uploading profile image'));
        }
      } catch (err) {
        emit(SocialPostImageUploadErrorState(err.toString()));
      }
    }
  }

  List<PostViewModel> posts = [];
  Future<void> getPosts() async {
    emit(SocialGetPostsLoadingState());
    try {
      var postsDocs =
          (await FirebaseFirestore.instance.collection('posts').get()).docs;
      if (postsDocs.isNotEmpty) {
        postsDocs.forEach((element) async {
          var post = element.data();
          var userData = (await FirebaseFirestore.instance
                  .collection('users')
                  .doc(post['userId'])
                  .get())
              .data();

          print("Get Post User -- $userData");
          print("Get Post Post -- $post");

          var likesList =
              (await element.reference.collection('likes').get()).docs;

          var existedPosts = posts.where((eleme) => eleme.uid == element.id);
          if (existedPosts.isEmpty) {
            posts.add(
              PostViewModel(
                uid: element.id,
                postImage: post['postImage'] ?? '',
                text: post['text'] ?? '',
                userImage: userData!['image'] ?? '',
                userName: userData['name'] ?? '',
                dateTime: post['dateTime'] ?? '',
                postLikes: likesList.length,
              ),
            );
          } else {
            var existed = existedPosts.first;
            existed.userImage = userData!['image'] ?? '';
            existed.postLikes = likesList.length;
          }
          emit(SocialGetPostsSuccessState());
        });
        emit(SocialGetPostsSuccessState());
      } else {
        SocialGetPostsErrorState("there is no posts");
      }
    } catch (err) {
      SocialGetPostsErrorState(err.toString());
    }
  }

  Future<void> likePost({required String postId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(userModel!.uid)
          .set({'like': true});
      emit(SocialPostLikeSuccessState());
    } catch (err) {
      emit(SocialPostLikeErrorState(err.toString()));
    }
  }

  List<SocialUserModel> users = [];
  Future<void> getUsers() async {
    emit(SocialGetAllUsersLoadingState());
    try {
      var usersDocs =
          (await FirebaseFirestore.instance.collection('users').get()).docs;
      if (usersDocs.isNotEmpty) {
        usersDocs.forEach((element) async {
          var user = element.data();

          print("Get All Users -- $user");
          if (users.where((eleme) => eleme.uid == element.id).isEmpty &&
              element.id != userModel!.uid)
            users.add(SocialUserModel.fromJson(element.id, user));
          emit(SocialGetAllUsersSuccessState());
        });
        emit(SocialGetAllUsersSuccessState());
      } else {
        SocialGetAllUsersErrorState("there is no users");
      }
    } catch (err) {
      SocialGetAllUsersErrorState(err.toString());
    }
  }

  Future<void> sendMessage({
    required String recieverId,
    required String dateTime,
    required String message,
  }) async {
    ChatMessageModel model = ChatMessageModel(
      message: message,
      dateTime: dateTime,
      recieverId: recieverId,
      senderId: userModel!.uid!,
    );
    try {
      var senderMessageDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uid)
          .collection('chats')
          .doc(recieverId)
          .collection('messages')
          .add(model.toJson());

      if (senderMessageDoc.id.isNotEmpty) {
        emit(SocialSendMessageSuccessState());
      } else {
        emit(SocialSendMessageErrorState(
            '${senderMessageDoc.path} not found / cannot send'));
      }

      var reciverMessageDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(recieverId)
          .collection('chats')
          .doc(userModel!.uid)
          .collection('messages')
          .add(model.toJson());

      if (reciverMessageDoc.id.isNotEmpty) {
        emit(SocialSendMessageSuccessState());
      } else {
        emit(SocialSendMessageErrorState(
            '${reciverMessageDoc.path} not found / cannot recieve'));
      }
    } catch (error) {
      emit(SocialSendMessageErrorState(error.toString()));
    }
  }

  List<ChatMessageModel> messages = [];

  void getMessages({required String recieverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (messages.where((elem) => elem.uid == element.id).isEmpty)
          messages.add(ChatMessageModel.fromJson(element.id, element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}
