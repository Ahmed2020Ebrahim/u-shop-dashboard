import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/colors.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.color,
    this.height,
    required this.child,
    this.width,
    this.padding,
    this.margin,
    this.borderRadius,
    this.alignment,
    this.borderColor,
  });
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
