import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class RestaurantAboutSection extends StatelessWidget {
  final String restaurantName;
  final List<String> features;

  const RestaurantAboutSection({
    Key? key,
    required this.restaurantName,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff5f8fa),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Animated Restaurant Name
          Row(textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لمحة عن ',
                style: TextStyle(
                  color: const Color(0xFF0E001A),
                  fontSize: 35,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              TypeWriter.text(
                 restaurantName,
                style: TextStyle(
                  color: const Color(0xFFF24D18),
                  fontSize: 35,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                ),
                duration: const Duration(milliseconds: 100), // Speed of typing
             textDirection: TextDirection.rtl, // Animation curve
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Features List
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(  textDirection: TextDirection.rtl,
              children: features.map((feature) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Color(0xFFF24D18)),
                  title: Text(  textDirection: TextDirection.rtl,
                    feature,
                    style: TextStyle(
                      color: const Color(0xFF0E001A),
                      fontSize: 18,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
