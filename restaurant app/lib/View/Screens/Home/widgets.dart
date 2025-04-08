import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Core/Models/PlatesModel.dart' as p;
import 'package:ecommerce/Core/ViewModels/HomeProvider.dart';
import 'package:ecommerce/View/Screens/productView/ProductPage.dart';
import 'package:ecommerce/View/Screens/productView/ProductPage2.dart';
import 'package:ecommerce/View/Screens/tableReservation/TablePreview.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../Core/Models/BestMeal.dart';
import '../../../Core/ViewModels/AuthProvider.dart';
import '../../Components/ecommerce_kit/src/ecommerce_kit.dart';
import 'package:ecommerce/Core/Models/BannerModel.dart';
import 'package:provider/provider.dart';
import '../itemsSearch/ItemsListPreview.dart';

class EcommerceWidgets {
  Widget discount(num num, double width) {
    return Container(
      //width: width*0.4,
      margin: EdgeInsets.fromLTRB(width * 0.5, 10, 0, 0),
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: const ShapeDecoration(
        color: Color(0xFFF24D18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'خصم ${num.toInt()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                height: 0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customBanner({
    required String imageLink,
    required double width,
    required String link,
  }) {
    return InkWell(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(link))) {
          await launchUrl(Uri.parse(link));
        } else {
          throw 'Could not launch $link';
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: imageLink,
          width: width * 0.9,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget colorBox(
      {required Widget child,
      required Color color1,
      required Color color2,
      required Color color3}) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 5,
      color: Colors.white,
      shape: const Border.fromBorderSide(BorderSide.none),
      child: Container(
        alignment: Alignment.topLeft,
        // height: height*0.4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color1,
              color2,
              color3,
              const Color(0x00d3c3c4),
            ],
            transform: const GradientRotation(1.2),
            // stops: [0.0, 1.0],
          ),
        ),
        child: child,
      ),
    );
  }

  Widget featuredButtonAsset(
      {String? image,
      String? title,
      Color? titleColor,
      String? titleFontFamily,
      String? subtitle,
      Color? subtitleColor,
      String? subtitleFontFamily,
      Function()? onTap,
      Function()? addToCart,
      Color? backgroundColor,
      BoxFit? imageBoxFit,
      double? imageWidth,
      double? featuredButtonWidth,
      int? rating}) {
    return EcommerceElement(
        child: Row(
      children: [
        Image.asset(
          image ?? 'assets/images/product.jpg',
          width: imageWidth ?? 60,
          fit: imageBoxFit ?? BoxFit.cover,
        ),
        10.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (title ?? 'Title')
                .text
                .fontFamily(titleFontFamily ?? 'sans-serif')
                .color(titleColor ?? Colors.black)
                .make(),
            (subtitle ?? '')
                .text
                .fontFamily(subtitleFontFamily ?? 'sans-serif')
                .color(subtitleColor ?? Colors.grey.shade500)
                .make(),
            InkWell(
              onTap: addToCart ?? () {},
              child: Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xfff24d18),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'أضف للسلة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            EcommerceElement.rating(
              count: rating ?? 3,
            ),
          ],
        )
      ],
    )
            .box
            .width(featuredButtonWidth ?? 200)
            .color(backgroundColor ?? Colors.white)
            .margin(const EdgeInsets.symmetric(horizontal: 4))
            .padding(const EdgeInsets.all(4))
            .roundedSM
            .outerShadowSm
            .make()
            .onInkTap(onTap ?? () {}));
  }

  Widget adsBanner(
      {String? image,
      String? title,
      Color? titleColor,
      String? titleFontFamily,
      String? subtitle,
      Color? subtitleColor,
      String? subtitleFontFamily,
      Function()? onTap,
      Color? backgroundColor,
      BoxFit? imageBoxFit,
      double? imageWidth,
      double? featuredButtonWidth,
      int? rating}) {
    return EcommerceElement(
        child: Row(
      children: [
        Image.asset(
          image ?? 'assets/images/product.jpg',
          width: imageWidth ?? 60,
          fit: imageBoxFit ?? BoxFit.cover,
        ),
        10.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (title ?? 'Title')
                .text
                .fontFamily(titleFontFamily ?? 'sans-serif')
                .color(titleColor ?? Colors.black)
                .make(),
            (subtitle ?? '')
                .text
                .fontFamily(subtitleFontFamily ?? 'sans-serif')
                .color(subtitleColor ?? Colors.grey.shade500)
                .make(),
            EcommerceElement.rating(
              count: rating ?? 3,
            )
          ],
        )
      ],
    )
            .box
            .width(featuredButtonWidth ?? 200)
            .color(backgroundColor ?? Colors.white)
            .margin(const EdgeInsets.symmetric(horizontal: 4))
            .padding(const EdgeInsets.all(4))
            .roundedSM
            .outerShadowSm
            .make()
            .onInkTap(onTap ?? () {}));
  }

  Widget profileImage({
    String? image,
    double? height,
    double? width,
    BoxFit? imageBoxFit,
    Function()? onTap,
  }) {
    return EcommerceElement(
      child: Image.asset(
        image ?? '',
        height: height ?? 100,
        width: width ?? 100,
        fit: imageBoxFit ?? BoxFit.cover,
      ).onInkTap(onTap ?? () {}),
    );
  }

  Widget productCardAsset(
      {String? image,
      String? title,
      Color? titleColor,
      String? titleFontFamily,
      double? titleFontSize,
      FontWeight? titleFontWeight,
      String? price,
      Color? priceColor,
      String? priceFontFamily,
      double? priceFontSize,
      FontWeight? priceFontWeight,
      String? description,
      Color? descriptionColor,
      String? descriptionFontFamily,
      double? descriptionFontSize,
      Color? backgroundColor,
      required double width,
      required double height,
      BoxFit? imageBoxFit,
      required Function() onTap,
      required Function() makeFav,
      required bool isFav,required bool hasFav,
      int? rating,
      required num num}) {
    return EcommerceElement(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        elevation: 10,
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      alignment: Alignment.center,
                      height: height * 0.5,
                      //  width: (width ?? 150) - 5,
                      fit: imageBoxFit ?? BoxFit.cover,
                      imageUrl: image ?? 'https://via.placeholder.com/400x250',

                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    10.heightBox,
                    (title ?? 'Product Title')
                        .text
                        .color(titleColor ?? Colors.black)
                        .fontFamily(titleFontFamily ?? 'sans-serif')
                        .fontWeight(titleFontWeight ?? FontWeight.bold)
                        .size(titleFontSize ?? 14)
                        .ellipsis
                        .make(),
                    10.heightBox,
                    if (rating != null)
                      EcommerceElement.rating(
                        isSelectable: false,
                        count: rating,
                      ),
                    10.heightBox,
                    (price ?? '2000EGP')
                        .text
                        .color(priceColor ?? Colors.black)
                        .fontFamily(priceFontFamily ?? 'sans-serif')
                        .fontWeight(priceFontWeight ?? FontWeight.normal)
                        .size(priceFontSize ?? 16)
                        .ellipsis
                        .make(),
                    (description ?? '')
                        .text
                        .color(descriptionColor ?? Colors.grey.shade500)
                        .fontFamily(descriptionFontFamily ?? 'sans-serif')
                        .size(descriptionFontSize ?? 12)
                        .overflow(TextOverflow.ellipsis)
                        .maxLines(2)
                        .make(),
                  ],
                )
                    .box
                    .color(backgroundColor ?? Colors.white)
                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                    .roundedSM
                    .padding(const EdgeInsets.all(8))
                    .make()
                    .onInkTap(onTap),
              ),
            ),
            if (hasFav)
              IconButton(
                onPressed: makeFav,
                icon:   Icon(isFav?Icons.favorite_rounded:Icons.favorite_border),
              ),
            if (num > 0) discount(num, width)
          ],
        ),
      ),
    );
  }

  Widget sliderAssets({
    required List<BannerItem> sliderList,
    double? aspectRatio,
    double? height,
    bool? enlargeCenterPage,
    bool? autoPlay,
    BoxFit? imageFit,
  }) {
    return EcommerceElement(
      child: VxSwiper.builder(
        aspectRatio: aspectRatio ?? 16 / 9,
        autoPlay: autoPlay ?? true,
        enlargeCenterPage: enlargeCenterPage ?? false,
        itemCount: sliderList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: sliderList[index].image,
              fit: imageFit ?? BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
                .box
                .roundedSM
                .clip(Clip.antiAlias)
                .margin(const EdgeInsets.symmetric(horizontal: 8))
                .make()
                .onInkTap(() async {
              final url = sliderList[index]
                  .link; // Assuming link is part of the Banner data.
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            }),
          );
        },
      ),
    );
  }
}

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomePageProvider>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xfff3efef),
      width: width,
      height: height * 0.09,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.tree.nodes.first.children!.length+1,
        itemBuilder: (context, index) {
          if(index==0){ return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/imgs/reservation.png',
                fit: BoxFit.cover,
              )
                  .box
                  .roundedSM
                  .clip(Clip.antiAlias)
                  .margin(const EdgeInsets.symmetric(horizontal: 8))
                  .make()
                  .onInkTap(() {

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TablePreview( ),
                  ),
                );
              }),
            )


          ;}

          final item = provider.tree.nodes.first.children![index-1 ];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/imgs/${item.name}.png',
              fit: BoxFit.cover,
            )
                .box
                .roundedSM
                .clip(Clip.antiAlias)
                .margin(const EdgeInsets.symmetric(horizontal: 8))
                .make()
                .onInkTap(() {
              final auth = context.read<AuthProvider>();
              final provider = context.read<HomePageProvider>();
              provider
                  .setFilterData([item.name], {'${index + 2}'}, auth.pb, '');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ItemsPreview2(title: 'Search'),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class BestMeal extends StatelessWidget {
  const BestMeal(
      {super.key,
      required this.width,
      required this.height,
      required this.itemList,
      required this.loading,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.title});
  final Color color1;
  final Color color2;
  final Color color3;
  final double width;
  final double height;
  final bool loading;
  final String title;
  final List<Meal> itemList;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : EcommerceWidgets().colorBox(
            child: Column(
              children: [
                EcommerceElement.menuItem(
                  onTap: () {
                    context.read<HomePageProvider>().clearFilter();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemsPreview1(
                        title: title,
                      ),
                    ));
                  },
                  trailing: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '',
                  ),
                  backgroundColor: Colors.grey[200],
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(itemList.length, (index) {
                      final item = itemList[index];
                      return EcommerceWidgets().productCardAsset(hasFav: false,
                        title: item.mealName, isFav: false,
                        height: height * 0.4,
                        width: width * 0.5, description: item.mealDescription,
                        price:
                            '\$${(item.discountedPrice * (1 - item.discount / 100)).toStringAsFixed(2)}',
                        image: item.image,
                        //  rating: Random().nextInt(4) + 2,
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductPage(meal: item),
                        )),
                        makeFav: () {},
                        num: item.discount,
                      );
                    }),
                  ),
                )
              ],
            ),
            color1: color1,
            color2: color2,
            color3: color3,
          );
  }
}

class BestPlates extends StatelessWidget {
  const BestPlates(
      {super.key,
      required this.width,
      required this.height,
      required this.itemList,
      required this.loading,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.title });
  final Color color1;
  final Color color2;
  final Color color3;
  final double width;
  final double height;
  final bool loading;
  final String title;
  final List<p.Plate> itemList;

  @override
  Widget build(BuildContext context) {
  HomePageProvider home= context.read<HomePageProvider>();
  PocketBase auth= context.read<AuthProvider>().pb;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : EcommerceWidgets().colorBox(
            child: Column(
              children: [
                EcommerceElement.menuItem(
                  onTap: () {
                    context.read<HomePageProvider>().clearFilter();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemsPreview2(
                        title: title,
                      ),
                    ));
                  },
                  trailing: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '',
                  ),
                  backgroundColor: Colors.grey[200],
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(itemList.length, (index) {
                      final item = itemList[index];
                      return EcommerceWidgets().productCardAsset(
                        title: item.plateName,
                        imageBoxFit: BoxFit.contain,
                        isFav:  item.isFav,
                        height: height * 0.4,
                        width: width * 0.5,
                        price: '${item.platePrice}\$',
                        image: item.plateImageUrl1,
                        description: item.plateDescription,
                        rating: item.plateEvaluation,
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductPage2(plateItem: item),
                        )),
                        makeFav:()=> home.removeFavPlates(auth,index),
                        num: 0, hasFav:true,
                      );
                    }),
                  ),
                )
              ],
            ),
            color1: color1,
            color2: color2,
            color3: color3,
          );
  }
}
