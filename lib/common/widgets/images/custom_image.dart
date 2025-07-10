import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import '../shimmer/custom_shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? imagePath;
  final Uint8List? memoryImage;
  final double width;
  final double height;
  final bool isCircular;
  final Color? color;
  final BoxFit? fit;
  final ImageType? imageType;
  final BorderRadius borderRadius;

  const CustomImage({
    super.key,
    this.imagePath = "",
    this.width = double.infinity,
    this.height = 200,
    this.isCircular = false,
    this.fit = BoxFit.cover,
    this.color,
    this.imageType,
    this.memoryImage,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath!.trim().isEmpty) {
      return const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      );
    }

    Widget imageWidget;

    if (imageType == ImageType.asset) {
      imageWidget = Image.asset(
        color: color,
        imagePath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
        ),
      );
    } else if (imageType == ImageType.memory) {
      imageWidget = Image.memory(
        memoryImage!,
        color: color,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
        ),
      );
    } else {
      imageWidget = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.grey),
        child: Image(
          image: CachedNetworkImageProvider(imagePath!),
          color: color,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return CustomShimmer(
              width: width,
              height: height,
              isCircular: isCircular,
              color: Colors.white,
            );
          },
        ),
      );
    }

    if (isCircular) {
      return ClipOval(
        child: SizedBox(
          width: width,
          height: height,
          child: imageWidget,
        ),
      );
    } else if (borderRadius != BorderRadius.zero) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    } else {
      return imageWidget;
    }
  }
}
