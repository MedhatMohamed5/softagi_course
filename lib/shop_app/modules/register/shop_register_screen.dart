import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:udemy_flutter/shop_app/modules/login/cubit/login_cubit.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';
import 'package:udemy_flutter/shop_app/modules/register/cubit/register_cubit.dart';
import 'package:udemy_flutter/shop_app/modules/register/cubit/register_states.dart';
import 'package:udemy_flutter/shop_app/shared/network/local/shop_cache_helper.dart';
import 'package:udemy_flutter/shop_app/shared/styles/colors.dart';
import 'package:udemy_flutter/shop_app/layout/shop_layout.dart';

class ShopRegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loginModel.message!),
                  backgroundColor: defaultColor,
                ),
              );
              ShopCacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              );

              navigateToReplacement(
                context,
                ShopLayout(),
              );
            } else {
              print(state.loginModel.message);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loginModel.message!),
                  backgroundColor: errorColor,
                ),
              );
              /*showToast(
                message: state.loginModel.message,
                backgroundColor: errorColor,
              );*/
            }
          }
        },
        builder: (context, state) {
          var registerCubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Signup now to see our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) return 'Please enter your name';
                            return null;
                          },
                          label: 'Full Name',
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your email';
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your password';
                            if (value.length < 6)
                              return 'Password at least 6 characters';
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          textCapitalization: TextCapitalization.none,
                          isPassword: registerCubit.isPassword,
                          suffix: registerCubit.suffixIcon,
                          suffixPressed: () {
                            registerCubit.changePasswordVisibility();
                          },
                          onSubmit: (value) =>
                              _submitForm(context, registerCubit),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your phone';
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition:
                              registerCubit.state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              _submitForm(context, registerCubit);
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context, ShopRegisterCubit registerCubit) {
    if (formKey.currentState!.validate()) {
      registerCubit.userRegister(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
      );
    }
  }
}
