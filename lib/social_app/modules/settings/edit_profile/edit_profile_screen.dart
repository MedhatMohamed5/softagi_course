import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key key}) : super(key: key);

  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUpdateUserSuccessState) Navigator.pop(context);
      },
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () async {
                  await socialCubit.updateUser(
                    name: nameController.text,
                    bio: bioController.text,
                    phone: phoneController.text,
                  );
                },
                child: Text(
                  'Update'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: _buildContent(context, socialCubit, state),
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, SocialCubit socialCubit, SocialStates state) {
    var userModel = socialCubit.userModel;
    var profileImage = socialCubit.profileImage;
    var coverImage = socialCubit.coverImage;

    nameController.text =
        nameController.text.isEmpty ? userModel.name : nameController.text;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));

    bioController.text =
        bioController.text.isEmpty ? userModel.bio : bioController.text;
    bioController.selection = TextSelection.fromPosition(
        TextPosition(offset: bioController.text.length));

    phoneController.text =
        phoneController.text.isEmpty ? userModel.phone : phoneController.text;
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (state is SocialUpdateUserLoadingState)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: LinearProgressIndicator(),
            ),
          Container(
            height: 190,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: coverImage == null
                                ? NetworkImage(
                                    userModel.coverImage,
                                  )
                                : FileImage(coverImage),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          socialCubit.getCoverImage();
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          radius: 25,
                          child: Icon(
                            IconBroken.Camera,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImage == null
                            ? NetworkImage(
                                userModel.image,
                              )
                            : FileImage(profileImage),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        socialCubit.getProfileImage();
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        radius: 25,
                        child: Icon(
                          IconBroken.Camera,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                  alignment: AlignmentDirectional.bottomEnd,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          defaultFormField(
            controller: nameController,
            type: TextInputType.name,
            validate: (value) {
              if (value.isEmpty) return 'Name must not be empty';
              return null;
            },
            label: 'Name',
            prefix: IconBroken.User,
          ),
          SizedBox(
            height: 10,
          ),
          defaultFormField(
            controller: phoneController,
            type: TextInputType.phone,
            validate: (value) {
              if (value.isEmpty) return 'Phone is required';
              return null;
            },
            label: 'phone',
            prefix: IconBroken.Call,
          ),
          SizedBox(
            height: 10,
          ),
          defaultFormField(
            controller: bioController,
            type: TextInputType.text,
            validate: (value) {
              return null;
            },
            label: 'bio',
            prefix: IconBroken.Info_Circle,
          ),
        ],
      ),
    );
  }
}
