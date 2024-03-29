import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_cubit.dart';
import 'package:udemy_flutter/social_app/layout/cubit/social_states.dart';
import 'package:udemy_flutter/social_app/models/chat_message_model.dart';
import 'package:udemy_flutter/social_app/models/social_user_model.dart';
import 'package:udemy_flutter/social_app/shared/styles/colors.dart';
import 'package:udemy_flutter/social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);
  final SocialUserModel userModel;

  final messageContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(recieverId: userModel.uid!);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final socialCubit = SocialCubit.get(context);
            var messages = socialCubit.messages
                .where(
                  (element) =>
                      element.recieverId == userModel.uid ||
                      element.senderId == userModel.uid,
                )
                .toList();
            return Scaffold(
              appBar: buildAppBar(),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ConditionalBuilder(
                  condition: messages.length > 0,
                  builder: (context) => Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => message(
                            messages[index],
                          ),
                          /*separatorBuilder: (context, index) => Divider(
                            height: 0,
                          ),*/
                          itemCount: messages.length,
                        ),
                      ),
                      const SizedBox(height: 4),
                      newMessageWidget(socialCubit),
                    ],
                  ),
                  fallback: (context) => Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                              'There is no messages yet. Start messaging Now'),
                        ),
                      ),
                      newMessageWidget(socialCubit),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget newMessageWidget(SocialCubit socialCubit) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: messageContrller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your message ...',
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        CircleAvatar(
          child: IconButton(
            onPressed: () async {
              if (messageContrller.text.trim().isNotEmpty) {
                await socialCubit.sendMessage(
                  recieverId: userModel.uid!,
                  dateTime: DateTime.now().toIso8601String(),
                  message: messageContrller.text.trim(),
                );
                messageContrller.text = '';
              }
            },
            icon: Icon(
              IconBroken.Send,
              color: Colors.white,
            ),

            // color: defaultColor,
          ),
        ),
      ],
    );
  }

  Widget message(
    ChatMessageModel messageModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: messageModel.senderId != userModel.uid
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: messageModel.senderId != userModel.uid
                ? defaultColor.withOpacity(.3)
                : Colors.grey.withOpacity(.3),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Text(messageModel.message),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              userModel.image.isNotEmpty
                  ? userModel.image
                  : 'https://image.freepik.com/free-photo/photo-unsure-doubtful-young-woman-holds-chin-looks-right-doubtfully-feels-hesitant_273609-18353.jpg',
            ),
          ),
          const SizedBox(width: 12),
          Text(userModel.name.isNotEmpty ? userModel.name : ''),
        ],
      ),
      titleSpacing: 0,
    );
  }
}
