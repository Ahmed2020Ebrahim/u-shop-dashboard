import 'package:flutter/material.dart';

class SideBarSubTitle extends StatelessWidget {
  const SideBarSubTitle({
    super.key,
    required this.subtitle,
  });
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
