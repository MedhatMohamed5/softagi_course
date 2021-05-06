import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/modules/login/cubit/social_login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(BuildContext context) =>
      BlocProvider.of<SocialLoginCubit>(context);

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginShowPasswordState());
  }

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.toString());

      emit(SocialLoginSuccessState());
    }).catchError((error) {
      print(error.message.toString());
      emit(SocialLoginErrorState(error.message.toString()));
    });
  }
}
