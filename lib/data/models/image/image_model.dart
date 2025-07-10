import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:ushop_web/utils/formatters/app_formatters.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizebytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;
  final String mime;
//not mapped
  final DropzoneFileInterface? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToUpdate;

//constructor
  ImageModel({
    this.id = "",
    required this.mime,
    required this.url,
    required this.folder,
    required this.fileName,
    this.sizebytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToUpdate,
    this.mediaCategory = "",
  });

  //empty image model
  static ImageModel empty() => ImageModel(mime: "", url: "", folder: "", fileName: "");
  String get createdAtFormatted => AppFormatters.formateDate(createdAt);
  String get updatedAtFormatted => AppFormatters.formateDate(updatedAt);
  //to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mime": mime,
      "url": url,
      "folder": folder,
      "fileName": fileName,
      "sizebytes": sizebytes,
      "fullPath": fullPath,
      "createdAt": createdAt!.toUtc(),
      "contentType": contentType,
      "mediaCategory": mediaCategory,
    };
  }

  //from snapshot
  factory ImageModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ImageModel(
        id: document.id,
        mime: data["mime"] ?? "",
        url: data['url'] ?? "",
        folder: data['folder'] ?? "",
        fileName: data['fileName'] ?? "",
        contentType: data['contentType'] ?? "",
        createdAt: data.containsKey("createdAt") && data["createdAt"] != null ? (data["createdAt"] as Timestamp).toDate() : null,
        updatedAt: data.containsKey("updatedAt") && data["updatedAt"] != null ? (data["updatedAt"] as Timestamp).toDate() : null,
        fullPath: data["fullPath"] ?? "",
        mediaCategory: data["mediaCategory"],
        sizebytes: data["sizebytes"] ?? 0,
      );
    } else {
      return ImageModel.empty();
    }
  }

  //from firebase metadata
  factory ImageModel.fromFirebaseMetaData(FullMetadata metaData, String folder, String fileName, String downloadUrl, String mime) {
    return ImageModel(
      mime: mime,
      url: downloadUrl,
      folder: folder,
      fileName: fileName,
      sizebytes: metaData.size,
      updatedAt: metaData.updated,
      createdAt: metaData.timeCreated,
      fullPath: metaData.fullPath,
      contentType: metaData.contentType,
    );
  }
}
