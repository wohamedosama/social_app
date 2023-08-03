import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/constants.dart';
import 'package:social_app1/models/message_model/message_model.dart';
import 'package:social_app1/models/post_model/post_model.dart';
import 'package:social_app1/models/social_app/social_user_model.dart';
import 'package:social_app1/modules/Post/post_screen.dart';
import 'package:social_app1/modules/chats/chats_screen.dart';
import 'package:social_app1/modules/feeds/feeds_screen.dart';
import 'package:social_app1/modules/settings/setings_screen.dart';
import 'package:social_app1/modules/users/users_screen.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel userModel = SocialUserModel();
  int currentIndex = 0;
  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = const [
    'Feeds ',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  File? profileImage;
  File? coverImage;
  final picker = ImagePicker();
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  List<SocialUserModel> users = [];
  List<MessageModel> messages = [];
  bool isDark = false;
  File? postImage;

  void getUserDate() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError(
      (error) {
        emit(SocialGetUserFailureState(error.toString()));
        print(error.toString());
      },
    );
  }

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUser();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  void changeAppMode() {
    isDark = !isDark;
    emit(SocialDarkModeSwitchState());
  }

  Future<XFile?> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedFailureState('No Selected Image'));
    }
  }

  Future<XFile?> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImagePickedFailureState('No Selected Image'));
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          profile: value,
        );
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileImagePickedFailureState(error));
      });
    }).catchError((error) {
      emit(SocialUploadProfileImagePickedFailureState(error));
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImagePickedSuccessState());
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePickedFailureState(error));
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePickedFailureState(error));
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? profile,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel.email,
      image: profile ?? userModel.image,
      cover: cover ?? userModel.cover,
      uId: userModel.uId,
      isEMailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserDate();
    }).catchError((error) {
      emit(SocialUserUpdateFailureState(error));
    });
  }

  Future<XFile?> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialImagePostSuccessState());
    } else {
      emit(SocialImagePostFailureState('No Selected Image'));
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImagePostState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        print(value);
      }).catchError((error) {
        emit(SocialCreatePostFailureState(error));
      });
    }).catchError((error) {
      emit(SocialCreatePostFailureState(error));
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostFailureState(error));
    });
  }

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJosn(element.data()));
        }).catchError((error) {});
      }
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostFailureState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostFailureState(error.toString()));
    });
  }

  void getAllUser() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserFailureState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      senderId: userModel.uId,
      dateTime: dateTime,
      text: text,
    );
    //send my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailureState(error.toString()));
    });
    //send receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageFailureState(error.toString()));
    });
  }

  void getMessages({
    required String receiver,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiver)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJsom(element.data()));
      }
      emit(SocialGetMessageSuccessState());
    });
  }
}
