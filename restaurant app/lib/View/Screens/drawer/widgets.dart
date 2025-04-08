import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mika_treeview/mika_treeview.dart';
import '../../../Core/Const/colors.dart';

class CustomTreeView extends StatelessWidget {
  final List<Node> tree;
  final Set<String> selectedValues;
  final Set<String> expandedNodes;
  final Function(Set<String>, List<String>) onSelectedValuesChanged;
  final Function(String, bool) onExpansionChanged;

  const CustomTreeView({
    super.key,
    required this.tree,
    required this.selectedValues,
    required this.expandedNodes,
    required this.onSelectedValuesChanged,
    required this.onExpansionChanged,
  });

  static List<String> getSelectedNames(
      List<Node> tree, List<String> selectedIds) {
    List<String> selectedNames = [];
    for (var id in selectedIds) {
      Node? node = _findNodeById(id, tree);
      if (node != null) {
        selectedNames.add(node.name);
      }
    }
    return selectedNames;
  }

  static Node? _findNodeById(String id, List<Node> nodes) {
    for (var node in nodes) {
      if (node.id == id) {
        return node;
      }
      if (node.children != null) {
        Node? result = _findNodeById(id, node.children!);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }

  List<TableRow> _buildTree(List<Node> nodes, int level) {
    List<TableRow> rows = [];
    for (var node in nodes) {
      rows.add(_buildNode(node, level));
      if (expandedNodes.contains(node.id) &&
          node.children != null &&
          node.children!.isNotEmpty) {
        rows.addAll(_buildTree(node.children!, level + 1));
      }
    }
    return rows;
  }

  TableRow _buildNode(Node node, int level) {
    bool isExpandable = node.children != null && node.children!.isNotEmpty;
    bool isSelectable = !isExpandable;

    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(left: level * 20.0),
          child: Row(
            children: [
              if (isExpandable)
                IconButton(
                  icon: Icon(
                    expandedNodes.contains(node.id)
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    onExpansionChanged(
                        node.id, !expandedNodes.contains(node.id));
                  },
                ),
              if (isSelectable)
                Checkbox(
                  value: selectedValues.contains(node.id),
                  onChanged: (bool? value) {
                    if (value == true) {
                      selectedValues.add(node.id);
                    } else {
                      selectedValues.remove(node.id);
                    }
                    List<String> selectedNames =
                        getSelectedNames(tree, selectedValues.toList());
                    onSelectedValuesChanged(
                        Set<String>.from(selectedValues), selectedNames);
                  },
                ),
              Expanded(
                child: Text(
                  node.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight:
                        isExpandable ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        scrollDirection: Axis.vertical,
        child: Table(
          columnWidths: const {0: IntrinsicColumnWidth()},
          children: _buildTree(tree, 0),
        ),
      ),
    );
  }
}

class Blur extends StatelessWidget {
  const Blur({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
          topEnd: Radius.circular(50), bottomEnd: Radius.circular(50)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 80,
          sigmaX: 80,
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xffd4e6e6).withOpacity(0.4),
                  const Color(0xff8ea9e5).withOpacity(0.3),
                ]),
            border: Border.all(width: 2, color: Colors.white.withOpacity(0.5)),
            borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(50), bottomEnd: Radius.circular(50)),
            color: Colors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}

// Reusable Drawer Item Widget
Widget buildDrawerItem(
  BuildContext context, {
  required String title,
  required IconData leadingIcon,
  required VoidCallback onTap,
}) {
  return ListTile(
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: MyColors.drawerIconColor),
    ),
    leading: Icon(leadingIcon, color: MyColors.drawerIconColor),
    onTap: onTap,
  );
}
