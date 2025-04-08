import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../Core/Models/PlatesModel.dart';
import '../../../Core/ViewModels/AuthProvider.dart';
import '../../../Core/ViewModels/HomeProvider.dart';
import '../../Components/ecommerce_kit/src/ecommerce_kit.dart';
import 'package:provider/provider.dart';

import '../itemsSearch/ItemsListPreview.dart';
class ProductPage2 extends StatelessWidget {
  final Plate plateItem;

  ProductPage2({required this.plateItem});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 16 : 18;
    double padding = screenWidth < 600 ? 8.0 : 16.0;
    double imageHeight = screenWidth < 600 ? 200 : 250;

    return Scaffold(
      appBar: AppBar(
        title: Text(plateItem.plateName ?? 'Plate Details'),
        backgroundColor: const Color(0xFFF46B3F),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: plateItem.plateImageUrl1 ?? 'https://via.placeholder.com/400x250',
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plateItem.plateName ?? 'Meal Name',
                    style: TextStyle(
                      fontSize: fontSize + 8,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF46B3F),
                    ),
                  ),
                  SizedBox(height: padding),

                    Row(
                      children: [
                        Text(
                          '\$${(plateItem.platePrice)!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: fontSize + 4,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        EcommerceElement.rating(isSelectable: false,
                          count: plateItem.plateEvaluation,
                        ),
                      ],
                    ),

                  SizedBox(height: padding),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plate Details',
                          style: TextStyle(
                            fontSize: fontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF46B3F),
                          ),
                        ),
                        SizedBox(height: padding),
                        ListView.builder(
                          itemCount:1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                            final plateController = TypeWriterController(
                              text: plateItem.plateDescription ??
                                  'No description available.',
                              duration: const Duration(milliseconds: 50),
                            );
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: padding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plateItem.plateName ?? 'Plate Name',
                                      style: TextStyle(
                                        fontSize: fontSize + 4,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFF46B3F),
                                      ),
                                    ),    Text(
                                      'Plate Type : ${plateItem.plateCategory}',
                                      style: TextStyle(
                                        fontSize: fontSize + 1,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFF46B3F),
                                      ),
                                    ),
                                    SizedBox(height: padding),
                                    TypeWriter(
                                      controller: plateController,
                                      builder: (context, value) {
                                        return Text(
                                          value.text,
                                          style: TextStyle(fontSize: fontSize),
                                        );
                                      },
                                    ),
                                    SizedBox(height: padding),
                                    Text(
                                      '\$${plateItem.platePrice!.toStringAsFixed(2) ?? '0.00'}',
                                      style: TextStyle(
                                        fontSize: fontSize + 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    if ( plateItem.ingredientsDetails.isNotEmpty) ...[

                                      SizedBox(height: padding),
                                      Text(
                                        'Ingredients:',
                                        style: TextStyle(
                                          fontSize: fontSize + 2,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFF46B3F),
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 8.0,
                                        children: plateItem.ingredientsDetails
                                            .map((ingredient) {
                                          return  InkWell(
                                            onTap: () {
                                              final auth=   context.read<AuthProvider>();
                                              final provider=   context.read<HomePageProvider>();
                                              provider.setFilterData([ingredient.ingredientName],
                                                  {ingredient.ingredientId}, auth.pb, '');
                                              Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => ItemsPreview2(
                                                  title: 'Search',
                                                ),
                                              ));
                                            },
                                            child: Chip(
                                              label: Text(
                                                  ingredient.ingredientName!),
                                              backgroundColor:
                                                  const Color(0xFFF46B3F)
                                                      .withOpacity(0.2),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
