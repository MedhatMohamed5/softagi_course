import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/cubit/new_post_states.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/post_model.dart';
import 'package:udemy_flutter/social_app/shared/components/components.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final socialCubit = SocialCubit.get(context);

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: () async {
                  if (textController.text.isNotEmpty) {
                    await socialCubit.createNewPost(
                      post: PostModel(
                        dateTime: DateTime.now().toString(),
                        text: textController.text.trim(),
                        userId: socialCubit.userModel!.uid!,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please provide some words for sharing'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Post'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          body: _buildBody(context, socialCubit, state),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, SocialCubit socialCubit, SocialStates state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (state is CreatePostLodingState) ...[
            LinearProgressIndicator(),
            SizedBox(height: 4),
          ],
          _createPostHeader(socialCubit),
          _createPostWidget(),
          if (socialCubit.postImage != null)
            _createPostImageSelected(socialCubit, context),
          _createPostBottom(socialCubit),
        ],
      ),
    );
  }

  Widget _createPostImageSelected(
    SocialCubit socialCubit,
    BuildContext context,
  ) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(socialCubit.postImage!),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            socialCubit.removePostImage();
          },
          icon: CircleAvatar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            radius: 25,
            child: Icon(
              Icons.close,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createPostBottom(SocialCubit socialCubit) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () async {
              await socialCubit.getPostImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Image),
                SizedBox(width: 4),
                Text('Add Photo'),
              ],
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text('# Tags'),
          ),
        ),
      ],
    );
  }

  Widget _createPostWidget() {
    return Expanded(
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          hintText: ('What\'s in your mind'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _createPostHeader(SocialCubit socialCubit) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage:
              NetworkImage(socialCubit.userModel!.image, scale: .4),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'Medhat Mohamed',
          ),
        ),
      ],
    );
  }
}
