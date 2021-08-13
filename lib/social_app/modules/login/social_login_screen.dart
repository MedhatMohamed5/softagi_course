import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/social_layout.dart';
import 'package:udemy_flutter/social_app/modules/login/cubit/social_login_cubit.dart';
import 'package:udemy_flutter/social_app/modules/login/cubit/social_login_states.dart';
import 'package:udemy_flutter/social_app/modules/register/social_register_screen.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';
import 'package:udemy_flutter/social_app/shared/network/local/social_cache_helper.dart';
import 'package:udemy_flutter/social_app/shared/styles/colors.dart';

class SocialLoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SocialLoginSuccessState) {
            SocialCacheHelper.saveData(
              key: 'uid',
              value: FirebaseAuth.instance.currentUser!.uid,
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged in successfully'),
                  backgroundColor: defaultColor,
                ),
              );
              navigateToReplacement(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          return _buildContent(context);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Scaffold(
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
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      'Login now to see your friends',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) return 'Please enter your email';
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
                        if (value!.isEmpty) return 'Please enter your password';
                        if (value.length < 6)
                          return 'Password at least 6 characters';
                        return null;
                      },
                      label: 'Password',
                      textCapitalization: TextCapitalization.none,
                      prefix: Icons.lock,
                      isPassword: SocialLoginCubit.get(context).isPassword,
                      suffix: SocialLoginCubit.get(context).suffixIcon,
                      suffixPressed: () {
                        SocialLoginCubit.get(context)
                            .changePasswordVisibility();
                      },
                      onSubmit: (value) => _submitForm(context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: SocialLoginCubit.get(context).state
                          is! SocialLoginLoadingState,
                      builder: (context) => defaultButton(
                        onPressed: () {
                          _submitForm(context);
                        },
                        text: 'Login',
                        isUpperCase: true,
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?!'),
                        TextButton(
                          child: Text('Register now!'.toUpperCase()),
                          onPressed: () {
                            navigateTo(
                              context,
                              SocialRegisterScreen(),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      SocialLoginCubit.get(context).userLogin(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
