import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import '../../../common/interfaces/tabels/table_displayable.dart';
import '../../../featuers/dashboard/widgets/order_table_data_cells.dart';
import '../address/address_model.dart';
import '../cart_item/cart_item_model.dart';

class OrderModel implements TableDisplayable {
  final String id;
  final String userId;
  OrderStatus orderStatus;
  final String userName;
  final String userEmail;
  final List<CartItemModel> items;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final AddressModel deliveryAddress;
  final String paymentMethod;
  final double orderTotalAmount;

  OrderModel({
    required this.id,
    required this.userId,
    required this.orderStatus,
    required this.userName,
    required this.userEmail,
    required this.items,
    required this.orderDate,
    required this.deliveryDate,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.orderTotalAmount,
  });

  //empty cart item
  static OrderModel emptyOrderModel() {
    return OrderModel(
      id: "",
      userId: "",
      orderStatus: OrderStatus.processing,
      userName: "",
      userEmail: "",
      items: [],
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      deliveryAddress: AddressModel.emptyAddressModel(),
      paymentMethod: "",
      orderTotalAmount: 0.0,
    );
  }

  /// Convert OrderModel to JSON (for Firestore/API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orderStatus': orderStatus.name,
      'userName': userName,
      'userEmail': userEmail,
      'items': items.map((item) => item.toJson()).toList(),
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'deliveryAddress': deliveryAddress.toJson(),
      'paymentMethod': paymentMethod,
      'orderTotalAmount': orderTotalAmount,
    };
  }

  //from snap shot
  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: snapshot.id,
      userId: data['userId'],
      // orderStatus: HelperFunctions.getRandomStatus(),
      orderStatus: HelperFunctions.getOrderStatusFromString(data["orderStatus"])!,
      userName: data['userName'],
      userEmail: data['userEmail'],
      items: (data['items'] as List).map((item) => CartItemModel.fromJson(item)).toList(),
      orderDate: DateTime.parse(data['orderDate']),
      deliveryDate: DateTime.parse(data['deliveryDate']),
      deliveryAddress: AddressModel.fromJson(data['deliveryAddress'], data['userId']),
      paymentMethod: data['paymentMethod'],
      orderTotalAmount: (data['orderTotalAmount'] as num).toDouble(),
    );
  }

  /// Create OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'],
      // orderStatus: HelperFunctions.getRandomStatus(),
      orderStatus: HelperFunctions.getOrderStatusFromString(json["orderStatus"])!,
      userName: json['userName'],
      userEmail: json['userEmail'],
      items: (json['items'] as List<dynamic>).map((item) => CartItemModel.fromJson(item)).toList(),
      orderDate: DateTime.parse(json['orderDate']),
      deliveryDate: DateTime.parse(json['deliveryDate']),
      deliveryAddress: AddressModel.fromJson(json['deliveryAddress'], id),
      paymentMethod: json['paymentMethod'],
      orderTotalAmount: (json['orderTotalAmount'] as num).toDouble(),
    );
  }

  //get order subtotal
  double get getOrderSubtotal {
    double subtotal = 0.0;
    for (var item in items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  @override
  List<DataCell> toDataCells({bool hasActions = false, void Function()? onDelet, void Function()? onEdit}) {
    return orderTabelDataCells(hasActions, this, onDelet: onDelet, onEdit: onEdit);
  }
}
