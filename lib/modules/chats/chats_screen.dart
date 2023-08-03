import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/cubits/social_cubit/social_cubit.dart';
import 'package:social_app1/modules/build_chat_items/build_chat_items.dart';
import 'package:social_app1/shared/components/divider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return BuildChatItem(
                    userModel: SocialCubit.get(context).users[index]);
              },
              itemCount: SocialCubit.get(context).users.length,
              separatorBuilder: (BuildContext context, int index) {
                return const DividerItem();
              },
            );
          },
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
