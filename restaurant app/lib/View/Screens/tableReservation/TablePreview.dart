import 'dart:convert';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../Core/ViewModels/TableSelectionProvider.dart';
import 'CustomContainer.dart';

class TablePreview extends StatefulWidget {
  const TablePreview({super.key});

  @override
  _TablePreviewState createState() => _TablePreviewState();
}

class _TablePreviewState extends State<TablePreview> {
  List<Map<String, dynamic>> tablePositions = [];

  final double svgWidth = 794; // Original width from Inkscape
  final double svgHeight = 794; // Original height from Inkscape

  @override
  void initState() {
    super.initState();
    _loadTablePositions();
  }

  Future<void> _loadTablePositions() async {
    String jsonString =
        await rootBundle.loadString('assets/table_positions.json');
    Map<String, dynamic> data = json.decode(jsonString);
    setState(() {
      tablePositions = List<Map<String, dynamic>>.from(data["tables"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableSelectionProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height * 0.4;

    // Preserve aspect ratio by using min scale
    double scale = min(screenWidth / svgWidth, screenHeight / svgHeight);

    // Calculate background positioning
    double bgWidth = svgWidth * scale;
    double bgHeight = svgHeight * scale;
    double bgLeft = (screenWidth - bgWidth) / 2;
    double bgTop = (screenHeight - bgHeight) / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF24D18),

      ),
      body:  Container(
        color: Colors.white,
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: ZoomableContainer(
            child: Stack(
              children: [
                // Background SVG
                Positioned(
                  left: bgLeft,
                  top: bgTop,
                  child: SvgPicture.asset(
                    'assets/RestaurantSvg/background.svg',
                    width: bgWidth,
                    height: bgHeight,
                    fit: BoxFit.contain, // Keep aspect ratio
                  ),
                ),
                for (var table in tablePositions)
                  Positioned(
                    left: bgLeft +
                        (table["x"] * scale) -
                        (85 * scale / 2), // Center horizontally
                    top: bgTop +
                        (table["y"] * scale) -
                        (103 * scale / 2), // Center vertically
                    child: SizedBox(
                      width: 85 * scale,
                      height: 103 * scale,
                      child: InkWell(hoverColor: Colors.black,
                          onTap: () {
                            provider.selectTable(table["id"]);
                          },
                          child: SvgPicture.asset(
                            provider.tableAvailability[table["id"]] == true
                                ? 'assets/RestaurantSvg/table.svg'
                                : 'assets/RestaurantSvg/tableb.svg',
                            fit: BoxFit.contain,
                            colorFilter: provider.selectedTable == table["id"]
                                ? const ColorFilter.mode(
                                Colors.redAccent, BlendMode.srcIn)
                                : null,
                          ).heartBeat(animate: provider.selectedTable == table["id"],infinite: true)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
