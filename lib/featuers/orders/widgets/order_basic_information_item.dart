import 'package:flutter/material.dart';

class OrderBasicInformationItem extends StatelessWidget {
  const OrderBasicInformationItem({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(label, style: Theme.of(context).textTheme.bodySmall), child],
      ),
    );
  }
}
