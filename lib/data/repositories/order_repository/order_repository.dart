import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';

import '../../../utils/constants/enums.dart';
import '../../models/order/order_model.dart';

class OrderRepository extends GetxController {
  //instance creator
  static OrderRepository get instance => Get.find();

  //data base instance
  final _db = FirebaseFirestore.instance;

  //fetch orders from database
  Future<List<OrderModel>> fetchOrders() async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      final snapShot = await _db.collection("Users").doc(userId).collection("Orders").get();
      final data = snapShot.docs.map((order) {
        return OrderModel.fromSnapshot(order);
      }).toList();

      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  Future<List<OrderModel>> fetchOrdersById(String userId) async {
    try {
      final orderSnapshot = await _db.collection('Users').doc(userId).collection('Orders').get();

      // Convert documents to list of maps
      final data = orderSnapshot.docs.map((order) {
        return OrderModel.fromSnapshot(order);
      }).toList();

      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //fetch order using id

  //save order
  Future<void> saveOrder(OrderModel order) async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      await _db.collection("Users").doc(userId).collection("Orders").add(order.toJson());
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //get order by id
  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      final userId = AuthRepository.instance.authUser!.uid;
      final docSnapshot = await _db.collection("Users").doc(userId).collection("Orders").doc(orderId).get();
      if (docSnapshot.exists) {
        return OrderModel.fromSnapshot(docSnapshot);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //fetch all users orders
  Future<List<OrderModel>> fetchAllUsersOrders() async {
    try {
      final snapShot = await FirebaseFirestore.instance.collectionGroup('Orders').get();

      final data = snapShot.docs.map((order) {
        return OrderModel.fromSnapshot(order);
      }).toList();

      return data;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went ";
    }
  }

  //update order status
  Future<void> updateOrderStatus(String userId, String orderId, OrderStatus orderStatus) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('Users').doc(userId).collection('Orders').doc(orderId);

      await docRef.update({'orderStatus': orderStatus.name});

      // Now read the document again to verify
      final snapshot = await docRef.get();

      final updatedStatus = snapshot.data()?['orderStatus'];

      if (updatedStatus == orderStatus.name) {
      } else {
        throw "Order status not updated correctly. Current value: $updatedStatus";
      }
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went ";
    }
  }
}
