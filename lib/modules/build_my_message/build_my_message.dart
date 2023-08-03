import 'package:flutter/material.dart';
import 'package:social_app1/constants.dart';
import 'package:social_app1/models/message_model/message_model.dart';

class BuildMyMessage extends StatelessWidget {
  const BuildMyMessage({
    super.key,
    required this.model,
  });

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Text(
          '${model.text}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
        ),
      ),
    );
  }
}
