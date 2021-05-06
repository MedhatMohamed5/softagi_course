import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        .then((value) {
      print(value.user.toString());

      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });

    // SocialDioHelper.postData(
    //   url: REGISTER,
    //   data: {
    //     'email': '$email',
    //     'password': '$password',
    //     'name': name,
    //     'phone': phone,
    //   },
    // ).then((value) {
    //   loginModel = SocialLoginModel.fromJson(value.data);

    //   emit(SocialRegisterSuccessState(loginModel));
    // }).catchError((error) {
    //   print(error);
    //   emit(SocialRegisterErrorState(error.toString()));
    // });
  }
}
