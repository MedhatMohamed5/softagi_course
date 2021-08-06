import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/cubit/new_post_states.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/modules/new_post/new_post_screen.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';
import 'package:udemy_flutter/social_app/shared/styles/colors.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(socialCubit.appBarTitles[socialCubit.currentIndex < 2
                ? socialCubit.currentIndex
                : socialCubit.currentIndex - 1]),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                tooltip: 'Notifications',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Search),
                tooltip: 'Search',
                onPressed: () {},
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: socialCubit.userModel != null,
            builder: (context) {
              return socialCubit.screens[socialCubit.currentIndex < 2
                  ? socialCubit.currentIndex
                  : socialCubit.currentIndex - 1];
              /*Column(
                children: [
                  // _verificationWidget(),
                ],
              );*/
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              socialCubit.changeBottomNav(index);
            },
            items: socialCubit.bottomNavItems,
            currentIndex: socialCubit.currentIndex,
          ),
        );
      },
    );
  }

  /*Widget _verificationWidget() {
    return ConditionalBuilder(
      condition: !FirebaseAuth.instance.currentUser.emailVerified,
      builder: (context) => Container(
        color: Colors.amber.withOpacity(.6),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text('Please verify your email'),
              ),
              TextButton(
                onPressed: () => sendVerification(context),
                child: Text('SEND'),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  void sendVerification(BuildContext context) {
    FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check your email'),
          backgroundColor: defaultColor,
        ),
      );
    }).catchError((error) {});
  }
}
