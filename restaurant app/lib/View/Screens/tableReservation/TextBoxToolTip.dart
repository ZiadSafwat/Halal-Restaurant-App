import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/TableSelectionProvider.dart';

class TableSelectionBar extends StatelessWidget {
  const TableSelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableSelectionProvider>(context);

    return Consumer<TableSelectionProvider>(
      builder: (context, textBoxProvider, _) {
        if (!textBoxProvider.isTablesSelectionVisible) {
          return const SizedBox.shrink(); // Hide when not needed
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.4, // Default open height (40%)
          minChildSize: 0.3, // Can shrink to 30%
          maxChildSize: 0.7, // Can expand to 70%
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag handle
                  Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Tab Bar (Stickers & Emojis)
                  DefaultTabController(
                    length: 2,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.blue,
                            tabs: const [
                              Tab(
                                  icon: Icon(Icons.table_bar),
                                  text: "Tables List"),
                              Tab(
                                  icon: Icon(Icons.av_timer),
                                  text: "reserved Datails"),
                            ],
                          ),

                          // Expandable content (scrolls inside the sheet)
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Stickers Tab
                                GridView.builder(
                                  controller:
                                      scrollController, // Enables scrolling inside the sheet
                                  padding: const EdgeInsets.all(10),

                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width < 600
                                            ? 4
                                            : 6, // Responsive
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),

                                  itemCount: provider.tableAvailability.length,
                                  itemBuilder: (context, index) {
                                    int tableId = index + 1;
                                    bool isAvailable =
                                        provider.tableAvailability[tableId] ??
                                            false;

                                    return ListTile(
                                      title: Text(isAvailable
                                          ? 'Available'
                                          : "not Available"),
                                      tileColor: provider.selectedTable ==
                                              tableId
                                          ? Colors.blueAccent.withOpacity(0.2)
                                          : isAvailable
                                              ? Colors.green.withOpacity(0.2)
                                              : Colors.red.withOpacity(0.2),
                                      leading: Text('Table $tableId'),
                                      onTap: isAvailable
                                          ? () => provider.selectTable(tableId)
                                          : null,
                                      enabled: isAvailable,
                                      trailing: isAvailable
                                          ? Icon(Icons.check_circle,
                                              color: Colors.green)
                                          : Icon(Icons.cancel,
                                              color: Colors.red),
                                    );
                                  },
                                ),
                                GridView.builder(
                                  controller:
                                      scrollController, // Enables scrolling inside the sheet
                                  padding: const EdgeInsets.all(10),

                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).size.width < 600
                                            ? 4
                                            : 6, // Responsive
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),

                                  itemCount: provider.tableAvailability.length,
                                  itemBuilder: (context, index) {
                                    int tableId = index + 1;
                                    bool isAvailable =
                                        provider.tableAvailability[tableId] ??
                                            false;

                                    return ListTile(
                                      title: Text(isAvailable
                                          ? 'Available'
                                          : "not Available"),
                                      tileColor: provider.selectedTable ==
                                              tableId
                                          ? Colors.blueAccent.withOpacity(0.2)
                                          : isAvailable
                                              ? Colors.green.withOpacity(0.2)
                                              : Colors.red.withOpacity(0.2),
                                      leading: Text('Table $tableId'),
                                      onTap: isAvailable
                                          ? () => provider.selectTable(tableId)
                                          : null,
                                      enabled: isAvailable,
                                      trailing: isAvailable
                                          ? Icon(Icons.check_circle,
                                              color: Colors.green)
                                          : Icon(Icons.cancel,
                                              color: Colors.red),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
