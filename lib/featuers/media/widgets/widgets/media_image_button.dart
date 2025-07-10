import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';

class MediaImageButton extends StatelessWidget {
  const MediaImageButton({
    this.isMemory = true,
    required this.onTap,
    this.imagePath = "",
    this.memoryImage,
    this.isSelectable = false,
    this.isSelected = false,
    this.onSelectedChange,
    super.key,
  });

  final void Function()? onTap;
  final String imagePath;
  final Uint8List? memoryImage;
  final bool isMemory;
  final bool? isSelectable;
  final bool? isSelected;
  final void Function(bool?)? onSelectedChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: RoundedContainer(
            padding: const EdgeInsets.all(AppSizes.sm),
            borderRadius: 25,
            color: AppColors.softGrey,
            child: isMemory
                ? Image.memory(
                    memoryImage!,
                    fit: BoxFit.contain,
                    width: 75,
                    height: 75,
                  )
                : CustomImage(
                    imagePath: imagePath,
                    fit: BoxFit.contain,
                    width: 75,
                    height: 75,
                  ),
          ),
        ),
        if (isSelectable!) Positioned(right: 0, top: 0, child: Checkbox(value: isSelected, onChanged: onSelectedChange)),
      ],
    );
  }
}
