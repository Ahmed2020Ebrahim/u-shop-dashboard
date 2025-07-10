import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/utils/constants/colors.dart';

class GenericTableWidget extends StatelessWidget {
  final DataTableSource source;
  final List<DataColumn> columns;
  final int rowsPerPage;
  final int? sortColumnIndex;
  final double tableHeight;
  final void Function(int)? onPageChanged;
  final double dataRowHeight;
  final bool sortAscending;
  final double minWidth;

  const GenericTableWidget({
    super.key,
    required this.columns,
    required this.source,
    this.rowsPerPage = 10,
    this.tableHeight = 760,
    this.onPageChanged,
    this.sortColumnIndex,
    this.dataRowHeight = 56,
    this.sortAscending = true,
    this.minWidth = 1000,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: tableHeight,
      child: Theme(
        data: Theme.of(context).copyWith(cardTheme: const CardTheme(color: AppColors.white, elevation: 0)),
        child: PaginatedDataTable2(
          availableRowsPerPage: const [2, 4, 5, 7, 8, 10],
          //columns show data
          columns: columns,
          //rows data
          source: source,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0, // No lines between rows/columns
          horizontalMargin: 12,
          rowsPerPage: rowsPerPage,
          showFirstLastButtons: true,
          showCheckboxColumn: true,
          sortAscending: sortAscending,
          onPageChanged: onPageChanged,
          dataRowHeight: dataRowHeight,
          renderEmptyRowsInTheEnd: false,
          onRowsPerPageChanged: (rowNum) {},
          sortColumnIndex: sortColumnIndex,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor: WidgetStateProperty.resolveWith((states) => AppColors.white),
          empty: Text("No data available", style: Theme.of(context).textTheme.bodyMedium),
          headingRowDecoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),

          //pagination

          //sorting
          sortArrowBuilder: (ascending, sorted) {
            if (sorted) {
              return Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down, size: 18);
            } else {
              return const Icon(Iconsax.arrow_3, size: 18);
            }
          },
          sortArrowAlwaysVisible: true,
          sortArrowAnimationDuration: const Duration(milliseconds: 300),
          sortArrowIcon: Icons.line_axis,
        ),
      ),
    );
  }
}
