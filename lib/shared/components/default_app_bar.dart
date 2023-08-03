import 'package:flutter/material.dart';
import 'package:social_app1/shared/icon_broken.dart';

Widget defaultAppBar({
  required BuildContext context,
  final String? title,
  final List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title!),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(IconBroken.Arrow___Left_2),
    ),
    actions: actions!,
  );
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({Key? key, this.title, this.actions}) : super(key: key);
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      actions: actions!,
    );
  }
}
