import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/interfaces/tabels/table_displayable.dart';

import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BannerModel implements TableDisplayable {
  String imageUrl;
  final String targetScreen;
  final bool isActive;
  String id;

  BannerModel({required this.id, required this.imageUrl, required this.targetScreen, required this.isActive});

  //empty banner model
  static BannerModel emptyBannerModel() => BannerModel(id: "", imageUrl: "", targetScreen: "", isActive: false);

  //from json
  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'],
        imageUrl: json['imageUrl'],
        targetScreen: json['targetScreen'],
        isActive: json['isActive'] ?? false,
      );

  //to json
  Map<String, dynamic> toJson() => {"id": id, 'imageUrl': imageUrl, 'targetScreen': targetScreen, 'isActive': isActive};

  // from snapshot
  factory BannerModel.fromSnapshotDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        id: data['id'] ?? "",
        imageUrl: data['imageUrl'] ?? "",
        targetScreen: data['targetScreen'] ?? "",
        isActive: data['isActive'] ?? false,
      );
    } else {
      return emptyBannerModel();
    }
  }

  @override
  List<DataCell> toDataCells({bool hasActions = false, void Function()? onDelet, void Function()? onEdit}) {
    return [
      DataCell(Row(
        children: [
          CustomImage(
            imagePath: imageUrl,
            height: 50,
            width: 80,
            fit: BoxFit.fill,
          ),
        ],
      )),
      DataCell(Text(targetScreen)),
      DataCell(Icon(
        isActive ? Iconsax.eye : Iconsax.eye_slash,
        color: AppColors.primary,
      )),
      DataCell(
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    onEdit!();
                  },
                  icon: const Icon(Iconsax.edit, color: AppColors.primary)),
              IconButton(
                onPressed: () {
                  onDelet!();
                },
                icon: const Icon(
                  Iconsax.trash,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
