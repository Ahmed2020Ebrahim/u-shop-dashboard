import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  String id = "app_settings";
  final String appImageUrl;
  final String appName;
  final String supportedEmail;
  final double taxRate;
  final double shippingCost;
  final double freeShippingThreshold;

  SettingsModel({required this.supportedEmail, required this.appImageUrl, required this.appName, required this.taxRate, required this.shippingCost, required this.freeShippingThreshold});

  //empty
  factory SettingsModel.empty() {
    return SettingsModel(
      supportedEmail: "",
      appImageUrl: "",
      appName: "",
      taxRate: 0.0,
      shippingCost: 0.0,
      freeShippingThreshold: 0.0,
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appImageUrl': appImageUrl,
      'appName': appName,
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'supportedEmail': supportedEmail,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      appImageUrl: json['appImageUrl'] ?? "",
      appName: json['appName'] ?? "",
      taxRate: json['taxRate'] ?? 0.0,
      shippingCost: json['shippingCost'] ?? 0.0,
      freeShippingThreshold: json['freeShippingThreshold'] ?? 0.0,
      supportedEmail: json['supportedEmail'] ?? "",
    );
  }

  //from snapshot
  factory SettingsModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return SettingsModel(
      appImageUrl: data['appImageUrl'] ?? "",
      appName: data['appName'] ?? "",
      taxRate: data['taxRate'] ?? 0.0,
      shippingCost: data['shippingCost'] ?? 0.0,
      freeShippingThreshold: data['freeShippingThreshold'] ?? 0.0,
      supportedEmail: data['supportedEmail'] ?? "",
    );
  }
}
