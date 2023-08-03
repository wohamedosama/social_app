import 'package:flutter/material.dart';
import 'package:social_app1/models/social_app/social_user_model.dart';
import 'package:social_app1/modules/chat_details/chat_details_screen.dart';
import 'package:social_app1/shared/components/navigator_method.dart';

class BuildChatItem extends StatelessWidget {
  const BuildChatItem({
    super.key,
    required this.userModel,
  });

  final SocialUserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigateTo.navigateTo(
          context,
          ChatDetailsScreen(userModel: userModel),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${userModel.image}',
              ),
            ),
            const SizedBox(width: 15.0),
            Text(
              '${userModel.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
