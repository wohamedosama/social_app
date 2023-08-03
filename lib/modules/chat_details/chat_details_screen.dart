import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/cubits/social_cubit/social_cubit.dart';
import 'package:social_app1/models/social_app/social_user_model.dart';
import 'package:social_app1/modules/build_my_message/build_my_message.dart';

import '../../constants.dart';
import '../../shared/icon_broken.dart';
import '../build_message/build_message.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;
  final TextEditingController messageController = TextEditingController();

  ChatDetailsScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiver: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        '${userModel.image}',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '${userModel.name}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModel.uId ==
                                  message.senderId) {
                                return BuildMyMessage(model: message);
                              }

                              return BuildMessage(model: message);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15);
                            },
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ....',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: defaultColor,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                  },
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
