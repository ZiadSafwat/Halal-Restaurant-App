import 'package:flutter/material.dart';

// ✅ Provider Class for Table Selection
class TableSelectionProvider extends ChangeNotifier {
  int? selectedTable;
  bool isTablesSelectionVisible = false;
  Map<int, bool> tableAvailability = {
    1: true,
    2: false,
    3: true,
    4: true,
    5: false,
    6: true,
    7: true,
    8: false,
    9: true
  };
  ThemeMode mode = ThemeMode.light;
  setMode() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    notifyListeners();
  }

  void selectTable(int tableId) {
    if (tableAvailability[tableId] == false) return;
    selectedTable = (selectedTable == tableId) ? null : tableId;
    notifyListeners();
  }

  void clearSelection() {
    selectedTable = null;
    notifyListeners();
  }

  void changeTableBarVisiablity() {
    isTablesSelectionVisible = !isTablesSelectionVisible;

    notifyListeners();
  }
}
