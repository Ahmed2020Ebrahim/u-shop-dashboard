import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool isSelectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.isSelectedAddress = false,
  });

  //empty model class
  factory AddressModel.emptyAddressModel() {
    return AddressModel(
      id: "",
      name: "",
      phoneNumber: "",
      street: "",
      city: "",
      state: "",
      postalCode: "",
      country: "",
      dateTime: DateTime.now(),
      isSelectedAddress: false,
    );
  }

  // convert snapshot to addressmodel
  factory AddressModel.fromSnapshot(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'] ?? "",
      name: data['name'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      street: data['street'] ?? "",
      city: data['city'] ?? "",
      state: data['state'] ?? "",
      postalCode: data['postalCode'] ?? "",
      country: data['country'] ?? "",
      dateTime: data['dateTime'] is Timestamp ? (data['dateTime'] as Timestamp).toDate() : DateTime.now(),
      isSelectedAddress: data['isSelectedAddress'] ?? false,
    );
  }

  // Convert a JSON object to an AddressModel instance
  factory AddressModel.fromJson(Map<String, dynamic> json, String id) {
    return AddressModel(
      id: id,
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      dateTime: DateTime.parse(json['dateTime']),
      isSelectedAddress: json['isSelectedAddress'] ?? false,
    );
  }

  // Convert an AddressModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'dateTime': dateTime!.toIso8601String(),
      'isSelectedAddress': isSelectedAddress,
    };
  }
}
