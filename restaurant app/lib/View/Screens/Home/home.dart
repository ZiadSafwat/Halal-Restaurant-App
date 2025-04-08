import 'package:ecommerce/Core/ViewModels/AuthProvider.dart';
import 'package:ecommerce/Core/ViewModels/HomeProvider.dart';
import 'package:ecommerce/View/Screens/drawer/drawer.dart';
import 'package:ecommerce/View/Screens/Home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import '../loadinIndicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final home = Provider.of<HomePageProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      home.refreshData(authProvider.pb);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: const DrawerRight(),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF24D18),
          actions: [
            Image.asset(
              width: width * 0.15,
              'assets/imgs/halal icon2.png',
              fit: BoxFit.scaleDown,
              scale: 3,
            )
          ],
        ),
        body: IceCreamIndicator(
          onRefresh: () async {
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            final homeProvider = Provider.of<HomePageProvider>(context, listen: false);
            await homeProvider.refreshData(authProvider.pb);
          },
          child: Consumer<HomePageProvider>(builder: (context, provider, _) {
            return Container(color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.heightBox,
                    // **First Banner (If available)**
                    if (provider.staticBannerList.isNotEmpty)
                      EcommerceWidgets().customBanner(
                        imageLink: provider.staticBannerList[0].image,
                        width: width,
                        link: provider.staticBannerList[0].link,
                      ),
                    10.heightBox,
                    const CategoryListView(),

                    if (provider.bestMealList != null)
                      BestMeal(
                        title: 'أقوى العروض',
                        color1: const Color(0xFFF46B3F),
                        color2: const Color(0xFFFF636C),
                        color3: const Color(0xFFD3C3C4),
                        loading: provider.isBestMealDealsLoading,
                        width: width,
                        height: height,
                        itemList: provider.bestMealList!,
                      ),
                    20.heightBox,
                    // **Second Banner**
                    if (provider.staticBannerList.length > 1)
                      EcommerceWidgets().customBanner(
                        imageLink: provider.staticBannerList[1].image,
                        width: width,
                        link: provider.staticBannerList[1].link,
                      ),
                    20.heightBox,
                    if (provider.mostSealedPlateList != null)
                      BestPlates(
                          color1: const Color(0xFFF46B3F),
                          color2: const Color(0xFFFF636C),
                          color3: const Color(0xFFD3C3C4),
                          width: width,
                          height: height,
                          itemList: provider.mostSealedPlateList!,
                          loading: provider.isPlatesLoading,
                          title: 'الأطباق الأكثر مبيعا'),

                    // slider
                    if (provider.sliderBannerList.isNotEmpty)
                      EcommerceWidgets().sliderAssets(
                        imageFit: BoxFit.contain,
                        height: height * 0.4,
                        autoPlay: true,
                        sliderList: provider.sliderBannerList,
                      ),
                    20.heightBox,
                    // **Third Banner**
                    if (provider.staticBannerList.length > 2)
                      EcommerceWidgets().customBanner(
                        imageLink: provider.staticBannerList[2].image,
                        width: width,
                        link: provider.staticBannerList[2].link,
                      ),
                    20.heightBox,
                    // **Fourth Banner**
                    if (provider.staticBannerList.length > 3)
                      EcommerceWidgets().customBanner(
                        imageLink: provider.staticBannerList[3].image,
                        width: width,
                        link: provider.staticBannerList[3].link,
                      ),
                    20.heightBox,
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
