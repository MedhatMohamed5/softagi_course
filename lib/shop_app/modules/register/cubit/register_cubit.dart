import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/models/login/shop_login_model.dart';
import 'package:udemy_flutter/shop_app/shared/network/endpoints.dart';
import 'package:udemy_flutter/shop_app/shared/network/remote/shop_dio_helper.dart';
import 'package:udemy_flutter/shop_app/modules/register/cubit/register_states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(BuildContext context) =>
      BlocProvider.of<ShopRegisterCubit>(context);

  IconData suffixIcon = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterShowPasswordState());
  }

  late ShopLoginModel loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    ShopDioHelper.postData(
      url: REGISTER,
      data: {
        'email': '$email',
        'password': '$password',
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
