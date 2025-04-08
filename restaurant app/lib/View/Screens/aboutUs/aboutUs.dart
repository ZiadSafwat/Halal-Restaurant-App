import 'package:ecommerce/View/Screens/aboutUs/widgets.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF24D18),
        foregroundColor: Colors.white,

        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Using the reusable component
              RestaurantAboutSection(
                restaurantName: 'مطعم الحلال',
                features: [
                  '🍽 أطباق حلال 100%',
                  '🧑‍🍳 مكونات طازجة',
                  '🏆 جودة عالية',
                  '🌟 تنوع في الأطباق',
                  '👨‍👩‍👧‍👦 مناسب للعائلات',
                  '🕋 التزام بالقيم',
                  '🌍 مكانك الأول للطعام الحلال',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
