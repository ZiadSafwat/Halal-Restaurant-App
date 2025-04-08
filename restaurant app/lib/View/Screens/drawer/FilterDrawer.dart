import 'package:ecommerce/Core/ViewModels/AuthProvider.dart';
import 'package:ecommerce/Core/ViewModels/HomeProvider.dart';
import 'package:ecommerce/View/Screens/drawer/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final Set<String> _expandedNodes = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(builder: (context, provider, _) {
      return Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        backgroundColor: Colors.white.withOpacity(0.9),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(50),
            bottomEnd: Radius.circular(50),
          ),
        ),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: CustomTreeView(
              tree: provider.tree.nodes,
              // Adjust as per your project
              selectedValues: provider.filterSelectedItems,
              expandedNodes: _expandedNodes,
              onSelectedValuesChanged: (values, names) {
                print(values)
                ;provider.setFilterData(names, values,
                    context.read<AuthProvider>().pb, provider.searchText);
              },
              onExpansionChanged: (String nodeId, bool isExpanded) {
                setState(() {
                  if (isExpanded) {
                    _expandedNodes.add(nodeId);
                  } else {
                    _expandedNodes.remove(nodeId);
                  }
                });
              },
            ),
          ),
        ),
      );
    });
  }
}
