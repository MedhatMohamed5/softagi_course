import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shop_app/layout/cubit/shop_states.dart';
import 'package:udemy_flutter/shop_app/models/login/shop_login_model.dart';
import 'package:udemy_flutter/shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        if (shopCubit.userModel != null) {
          nameController.text = shopCubit.userModel.data!.name!;
          emailController.text = shopCubit.userModel.data!.email!;
          phoneController.text = shopCubit.userModel.data!.phone!;
        }
        return _buildContent(
          context: context,
          userModel: shopCubit.userModel,
          state: state,
        );
      },
    );
  }

  Widget _buildContent(
          {required BuildContext context,
          required ShopLoginModel userModel,
          required ShopStates state}) =>
      ConditionalBuilder(
        condition: userModel != null,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConditionalBuilder(
            condition: state is! ShopUpdateUserLoadingState,
            builder: (context) => Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person_outlined,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email_outlined,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  defaultButton(
                      onPressed: () => _updateProfile(context), text: 'update'),
                ],
              ),
            ),
            fallback: (context) => Center(child: LinearProgressIndicator()),
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );

  void _updateProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ShopCubit.get(context).updateUserData({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
      });
    }
  }
}
