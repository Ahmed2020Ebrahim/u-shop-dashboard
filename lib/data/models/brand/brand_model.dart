import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';

import '../../../common/interfaces/tabels/table_displayable.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BrandModel implements TableDisplayable {
  String id;
  String imageUrl;
  bool isFeatured;
  final String name;
  final int productsCount;
  //brandCategoriesIds
  final List<String>? brandCategoriesIds;

  BrandModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.imageUrl,
    required this.isFeatured,
    this.brandCategoriesIds,
  });

  //empty banner model
  static BrandModel emptyBrandModel() => BrandModel(id: "", name: "", productsCount: 0, imageUrl: "", isFeatured: false, brandCategoriesIds: []);

  //from json
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      imageUrl: json['image'] ?? "",
      productsCount: json['productsCount'] ?? 0,
      isFeatured: json['isFeatured'] ?? false,
      brandCategoriesIds: json['brandCategoriesIds'] ?? [],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'productsCount': productsCount,
        'imageUrl': imageUrl,
        "isFeatured": isFeatured,
        "brandCategoriesIds": brandCategoriesIds,
      };

  // from snapshot
  factory BrandModel.fromSnapshotDocument(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      List<String> brandCategoriesIds = data['brandCategoriesIds'] != null ? List<String>.from(data['brandCategoriesIds']) : [];
      return BrandModel(
        id: data['id'] ?? "",
        name: data['name'] ?? "",
        imageUrl: data['imageUrl'] ?? "",
        productsCount: data['productsCount'] ?? 0,
        isFeatured: data['isFeatured'] ?? false,
        brandCategoriesIds: brandCategoriesIds,
      );
    } else {
      return emptyBrandModel();
    }
  }

  @override
  List<DataCell> toDataCells({bool hasActions = false, void Function()? onDelet, void Function()? onEdit}) {
    return [
      DataCell(Row(
        children: [
          CustomImage(
            imagePath: imageUrl,
            height: 30,
            width: 30,
            color: Colors.black,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(name),
        ],
      )),
      DataCell(Text(productsCount.toString())),
      DataCell(Icon(Icons.favorite, color: isFeatured ? AppColors.error : AppColors.darkGrey)),
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
