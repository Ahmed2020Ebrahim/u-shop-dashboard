import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../interfaces/tabels/table_displayable.dart';

class GenericDataTableSource<T extends TableDisplayable> extends DataTableSource {
  final List<T> items;
  final List<bool> selectedItems;
  final void Function(int index)? onTap;
  final bool hasActions;
  final void Function(int index)? onDelet;
  final void Function(int index)? onEdit;

  GenericDataTableSource({required this.items, this.onTap, this.hasActions = false, this.onDelet, this.onEdit}) : selectedItems = List<bool>.filled(items.length, false);

  @override
  DataRow2? getRow(int index) {
    if (index >= items.length) return null;
    return DataRow2.byIndex(
      onTap: () {
        if (onTap != null) {
          onTap!(index);
        }
      },
      selected: selectedItems[index],
      onSelectChanged: (value) {
        if (value != null) {
          selectedItems[index] = value;
          notifyListeners();
        }
      },
      index: index,
      cells: items[index].toDataCells(
        hasActions: hasActions,
        onDelet: () {
          //onDelet
          if (onDelet != null) {
            onDelet!(index);
          }
        },
        onEdit: () {
          //onEdit
          if (onEdit != null) {
            onEdit!(index);
          }
        },
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
