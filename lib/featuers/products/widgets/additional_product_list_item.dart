import 'package:flutter/material.dart';

import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/colors.dart';

class AdditionalProductListItem extends StatelessWidget {
  const AdditionalProductListItem({
    required this.imagePath,
    required this.onTap,
    required this.onRemove,
    this.isActive = false,
    super.key,
  });

  final String imagePath;
  final void Function()? onTap;
  final void Function()? onRemove;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? AppColors.primary : Colors.transparent,
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: CustomImage(
              imagePath: imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        TextButton(
          onPressed: onRemove,
          child: Text(
            "Remove",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.error),
          ),
        )
      ],
    );
  }
}
