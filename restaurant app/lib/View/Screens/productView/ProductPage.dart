import 'package:ecommerce/Core/ViewModels/AuthProvider.dart';
import 'package:ecommerce/Core/ViewModels/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../Core/Models/BestMeal.dart';
import '../itemsSearch/ItemsListPreview.dart';
import 'package:provider/provider.dart';
class ProductPage extends StatelessWidget {
  final Meal meal;

  ProductPage({required this.meal});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 16 : 18;
    double padding = screenWidth < 600 ? 8.0 : 16.0;
    double imageHeight = screenWidth < 600 ? 200 : 250;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.mealName ?? 'Meal Details'),
        backgroundColor: const Color(0xFFF46B3F),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: meal.image ?? 'https://via.placeholder.com/400x250',
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.mealName ?? 'Meal Name',
                    style: TextStyle(
                      fontSize: fontSize + 8,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF46B3F),
                    ),
                  ),

                  SizedBox(height: padding),
                  if (meal.discountedPrice != null)
                    Row(
                      children: [
                        Text(
                          '\$${(meal.discountedPrice! * (1 - meal.discount! / 100)).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: fontSize + 4,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (meal.discount != null)
                          Text(
                            '\$${(meal.discountedPrice!).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: fontSize + 4,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  Text(
                    meal.mealDescription,
                    style: TextStyle(
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFFF46B3F),
                    ),
                  ),
                  if (meal.discountLastDate != null)
                    Padding(
                      padding: EdgeInsets.only(top: padding),
                      child: SlideCountdown(
                        duration: meal.discountLastDate!.difference(DateTime.now()),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  SizedBox(height: padding),
                  if (meal.plates != null && meal.plates!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'Consisted of this  Plates:',
                          style: TextStyle(
                            fontSize: fontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF46B3F),
                          ),
                        ),
                        SizedBox(height: padding),
                        ListView.builder(
                          itemCount: meal.plates!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var plate = meal.plates![index];
                            final plateController = TypeWriterController(
                              text: plate.plateDescription ?? 'No description available.',
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
                                      plate.plateName ?? 'Plate Name',
                                      style: TextStyle(
                                        fontSize: fontSize + 4,
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
                                      '\$${plate.platePrice?.toStringAsFixed(2) ?? '0.00'}',
                                      style: TextStyle(
                                        fontSize: fontSize + 2,
                                        color: Colors.green,
                                      ),
                                    ),
                                    if (plate.ingredients != null && plate.ingredients!.isNotEmpty) ...[
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
                                        children: plate.ingredients!.map((ingredient) {
                                          return InkWell(
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
                                            },                                            child: Chip(
                                              label: Text(ingredient.ingredientName!),
                                              backgroundColor: const Color(0xFFF46B3F).withOpacity(0.2),
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
