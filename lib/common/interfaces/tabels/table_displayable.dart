import "package:flutter/material.dart";

abstract class TableDisplayable {
  // Returns the data of the cells
  List<DataCell> toDataCells({
    bool hasActions = false,
    void Function()? onDelet,
    void Function()? onEdit,
  });
}
