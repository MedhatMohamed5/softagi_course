import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/social_user_model.dart';
import 'package:udemy_flutter/social_app/modules/settings/edit_profile/edit_profile_screen.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        var userModel = socialCubit.userModel;
        return _buildContent(context, userModel);
      },
    );
  }

  Padding _buildContent(BuildContext context, SocialUserModel userModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 190,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          userModel.coverImage,
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      userModel.image,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            userModel.name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            userModel.bio.isEmpty ? 'Bio...' : userModel.bio,
            style: Theme.of(context).textTheme.caption,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '150',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          'Friends',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '1,445',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          'Fllowers',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '55',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          'Followings',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Add Photos'),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              OutlinedButton(
                onPressed: () {
                  navigateTo(context, EditProfileScreen());
                },
                child: Icon(IconBroken.Edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
