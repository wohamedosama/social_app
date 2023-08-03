import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/models/social_app/social_user_model.dart';

part 'social_register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitial());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      // emit(SocialRegisterSuccessState());
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterFailureState(error));
      print(error.toString());
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      isEMailVerified: false,
      image:
          'https://img.freepik.com/free-vector/mysterious-gangster-character_23-2148473800.jpg?w=740&t=st=1688870150~exp=1688870750~hmac=3ad5e7dc8cef34d3a203a4b9919e69ba08b212f9193f0a7ff46099ab7f25dc91',
      bio: 'Write your bio...',
      cover:
          'https://img.freepik.com/free-photo/galactic-night-sky-astronomy-science-combined-generative-ai_188544-9656.jpg?w=1060&t=st=1688877194~exp=1688877794~hmac=9e381291c406dbc7e41390a88ea12d51b8a549ba806a1a3dc978a0154e1b7465',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccess());
    }).catchError((error) {
      emit(SocialCreateUserFailure(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }
}
