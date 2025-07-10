// import 'package:flutter/material.dart';

// import '../../../utils/typedefs/app_typedefs.dart';

// // typedef ColumnBuilder<T> = List<DataColumn> Function();

// class TableColumnProvider {
//   //the static registry of column builders
//   // This is a map that associates a type with a function that builds columns for that type.
//   // The key is the type, and the value is a function that returns a list of DataColumn.
//   static final Map<Type, ColumnBuilder> _registry = {};

//   // This method allows you to register a column builder for a specific type.
//   // It takes a ColumnBuilder function as an argument and stores it in the _registry map.
//   // The type T is the key, and the builder function is the value.
//   // This allows you to define how the columns should be built for different types of data.
//   static void register<T>(ColumnBuilder<T> builder) {
//     _registry[T] = builder;
//   }

//   // This method retrieves the columns for a specific type T.
//   // It looks up the type in the _registry map and calls the corresponding builder function.
//   // If no builder is found for the type, it throws an exception.
//   // This allows you to get the columns dynamically based on the type of data you are working with.

//   static List<DataColumn> getColumns<T>() {
//     final builder = _registry[T];
//     if (builder != null) {
//       return builder();
//     } else {
//       throw Exception('No column builder registered for type $T');
//     }
//   }
// }
