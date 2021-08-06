import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/models/social_user_model.dart';
import 'package:udemy_flutter/social_app/modules/register/cubit/social_register_states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(BuildContext context) =>
      BlocProvider.of<SocialRegisterCubit>(context);

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterShowPasswordState());
  }

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print(value.user.toString());

      await createUser(
        userModel: SocialUserModel(
          uid: value.user.uid,
          email: value.user.email,
          phone: phone,
          name: name,
          isEmailVerified: false,
          bio: '',
          coverImage:
              'https://image.freepik.com/free-photo/crazy-overjoyed-woman-makes-rock-n-roll-gesture-wears-transparent-glasses-striped-sweater-models-against-white-wall-smiling-female-rocker-gestures-indoor-alone-horn-gesture-concept_273609-28882.jpg',
          image:
              'https://image.freepik.com/free-photo/crazy-overjoyed-woman-makes-rock-n-roll-gesture-wears-transparent-glasses-striped-sweater-models-against-white-wall-smiling-female-rocker-gestures-indoor-alone-horn-gesture-concept_273609-28882.jpg',
        ),
      );
      if (state is SocialCreateUserSuccessState) {
        emit(SocialRegisterSuccessState());
      }
      if (state is SocialCreateUserErrorState) {
        SocialCreateUserErrorState current =
            state as SocialCreateUserErrorState;
        emit(SocialRegisterErrorState(current.error));
      }
    }).catchError((error) {
      print(error.message.toString());
      emit(SocialRegisterErrorState(error.message.toString()));
    });
  }

  Future<void> createUser({@required SocialUserModel userModel}) async {
    emit(SocialCreateUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toJson())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.message.toString());
      emit(SocialCreateUserErrorState(error.message.toString()));
    });
  }
}
