import 'package:flutter/material.dart';

import '../../models/message_model/message_model.dart';

class BuildMessage extends StatelessWidget {
  const BuildMessage({
    super.key,
    required this.model,
  });

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(12),
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
