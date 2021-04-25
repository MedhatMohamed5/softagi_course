import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/modules/login/cubit/login_cubit.dart';
import 'package:udemy_flutter/shop_app/modules/login/cubit/login_states.dart';
import 'package:udemy_flutter/shop_app/modules/register/shop_register_screen.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
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
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Login now to see our hot offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                          if (value.isEmpty) return 'Please enter your email';
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
                          if (value.isEmpty)
                            return 'Please enter your password';
                          if (value.length < 6)
                            return 'Password at least 6 characters';
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffixIcon,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmit: (value) => _submitForm(context),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: ShopLoginCubit.get(context).state
                            is! ShopLoginLoadingState,
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
                                ShopRegisterScreen(),
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
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (formKey.currentState.validate()) {
      ShopLoginCubit.get(context).userLogin(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
