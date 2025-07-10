import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/interfaces/tabels/table_displayable.dart';

import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CategoryModel extends TableDisplayable {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  List<dynamic>? subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = "",
    required this.isFeatured,
    required this.subCategories,
  });

  //
  static CategoryModel emptyCategoryModel() => CategoryModel(id: '', name: '', image: '', isFeatured: false, subCategories: []);

  //
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      parentId: json['parent_id'] ?? "",
      isFeatured: json['is_featured'] ?? false,
      subCategories: json['sub_categories'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'parent_id': parentId,
      'is_featured': isFeatured,
      'sub_categories': subCategories,
    };
  }

  factory CategoryModel.fromSnapshotDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? "",
        image: data['image'] ?? "",
        parentId: data['parent_id'] ?? "",
        isFeatured: data['is_featured'] ?? false,
        subCategories: data["sub_categories"],
      );
    } else {
      return emptyCategoryModel();
    }
  }

  @override
  List<DataCell> toDataCells({bool hasActions = false, void Function()? onDelet, void Function()? onEdit}) {
    return [
      DataCell(Row(
        children: [
          CustomImage(
            imagePath: image,
            height: 30,
            width: 30,
            color: Colors.black,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(name),
        ],
      )),
      const DataCell(Text("parent")),
      DataCell(Icon(Icons.favorite, color: isFeatured ? AppColors.darkGrey : AppColors.error)),
      //fore date
      const DataCell(Text(" ")),
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
                  icon: const Icon(Iconsax.trash, color: AppColors.error)),
            ],
          ),
        ),
      ),
    ];
  }
}
