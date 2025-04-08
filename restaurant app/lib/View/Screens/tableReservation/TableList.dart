// ✅ Table List with Selection
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/ViewModels/TableSelectionProvider.dart';


class TableList extends StatelessWidget {
  const TableList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableSelectionProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.6,
      child: ListView.builder(
        itemCount: provider.tableAvailability.length,
        itemBuilder: (context, index) {
          int tableId = index + 1;
          bool isAvailable = provider.tableAvailability[tableId] ?? false;

          return ListTile(
            title: Text(isAvailable ? 'Available' : "not Available"),
            tileColor: provider.selectedTable == tableId
                ? Colors.blueAccent.withOpacity(0.2)
                : isAvailable
                ? Colors.green.withOpacity(0.2)
                : Colors.red.withOpacity(0.2),
            leading: Text('Table $tableId'),
            onTap: isAvailable ? () => provider.selectTable(tableId) : null,
            enabled: isAvailable,
            trailing: isAvailable
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.cancel, color: Colors.red),
          );
        },
      ),
    );
  }
}