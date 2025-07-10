// import 'package:data_table_2/data_table_2.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:ushop_web/data/controllers/products/products_controller.dart';
// import '../../common/widgets/tables/table_column_provider.dart';
// import '../../data/models/brand/brand_model.dart';
// import '../../data/models/products/product_model.dart';

// class RegisterTableColumnsServices extends GetxService {
//   Future<RegisterTableColumnsServices> init() async {
//     _registerTableColumns();
//     return this;
//   }

//   void _registerTableColumns() {
//     TableColumnProvider.register<Product>(() {
//       final ProductController productController = Get.find<ProductController>();
//       return [
//         const DataColumn2(label: Text("Product")),
//         const DataColumn2(label: Text("Stock")),
//         const DataColumn2(label: Text("Brand")),
//         DataColumn2(
//           label: const Text("Price"),
//           onSort: (columnIndex, ascending) async {
//             await productController.reOrderProducts(
//               "price",
//               ascending,
//             );
//             productController.allProducts.refresh();
//             productController.update();
//           },
//         ),
//         const DataColumn2(label: Text("Date")),
//         const DataColumn2(label: Text("Action")),
//       ];
//     });

//     TableColumnProvider.register<BrandModel>(() => [
//           const DataColumn2(label: Text("name")),
//           const DataColumn2(label: Text("count")),
//           const DataColumn2(label: Text("Action")),
//         ]);
//   }

//   // void _sortProductsByPrice(bool ascending) {
//   //   AppLogger.error("message");
//   //   // Implement sorting logic here
//   //   ProductController.instance.reOrderProducts("price", ascending);
//   //   ProductController.instance.allProducts.refresh();
//   //   ProductController.instance.update();
//   // }
// }
