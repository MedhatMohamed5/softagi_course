import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/social_user_model.dart';

class ChatssScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialCubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: socialCubit.users.length > 0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(socialCubit.users[index]),
            separatorBuilder: (context, index) => Divider(
              height: 0,
            ),
            itemCount: socialCubit.users.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel user) => InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  user.image.isNotEmpty
                      ? user.image
                      : 'https://image.freepik.com/free-photo/photo-unsure-doubtful-young-woman-holds-chin-looks-right-doubtfully-feels-hesitant_273609-18353.jpg',
                  scale: .3,
                ),
              ),
              SizedBox(width: 12),
              Text(
                user.name.isNotEmpty ? user.name : '',
              ),
            ],
          ),
        ),
      );
}
