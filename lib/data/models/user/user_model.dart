import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/interfaces/tabels/table_displayable.dart';

import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class UserModel extends TableDisplayable {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profileImage;
  final String role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.role,
  });

  //user from json
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'],
      role: json['role'] ?? "user",
    );
  }

  // user to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userName'] = userName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['profileImage'] = profileImage;
    data['addresses'] = [];
    data['role'] = role;
    return data;
  }

  // fullname getter
  String get getFullName => "$firstName $lastName";

  //empty user creator
  static UserModel empty() => UserModel(
        id: "",
        firstName: "",
        lastName: "",
        userName: "",
        email: "",
        phoneNumber: "",
        profileImage: "",
        role: "",
      );

  //name parts as a list
  static List<String> nameParts(String fullName) => fullName.split(" ");

  //generate user name
  static String generatUserName(String name) {
    List<String> nameParts = name.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUserName = "$firstName$lastName";
    String userNameWithPrefix = "ushop_$camelCaseUserName";
    return userNameWithPrefix;
  }

  //usermodel creator from firebase snabshot documents
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return UserModel(
        id: document.id,
        firstName: data!["firstName"] ?? "",
        lastName: data["lastName"] ?? "",
        userName: data["userName"] ?? "",
        email: data["email"] ?? "",
        phoneNumber: data["phoneNumber"] ?? "",
        profileImage: data["profileImage"] ?? "",
        role: data['role'] ?? "user",
      );
    } else {
      return empty();
    }
  }

  @override
  List<DataCell> toDataCells({bool hasActions = false, void Function()? onDelet, void Function()? onEdit}) {
    return [
      //image and name
      DataCell(Row(
        children: [
          CustomImage(
            imagePath: profileImage,
            height: 30,
            width: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Text(userName),
        ],
      )),
      //email
      DataCell(Text(email)),
      //phone number
      DataCell(Text(phoneNumber)),
      //date
      const DataCell(Text(" ")),

      //actions
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
                  icon: const Icon(Iconsax.eye, color: AppColors.primary)),
              IconButton(onPressed: () {}, icon: const Icon(Iconsax.trash, color: AppColors.error)),
            ],
          ),
        ),
      ),
    ];
  }
}
