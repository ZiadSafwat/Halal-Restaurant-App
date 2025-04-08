import 'package:ecommerce/Core/Models/PlatesModel.dart';
import 'package:ecommerce/Core/ViewModels/AuthProvider.dart';
import 'package:ecommerce/Core/ViewModels/FavoriteProvider.dart';
import 'package:ecommerce/View/Screens/productView/ProductPage2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Components/ecommerce_kit/src/ecommerce_kit.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({
    super.key,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Plate> getFavPlates(FavoriteProvider provider) {
    return provider.favoritePlates;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFF24D18),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Favorite Plates',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, _) {
          final favPlates = getFavPlates(provider);
          return
            SafeArea(
            child:provider.isFavLoading? Center(child: CircularProgressIndicator(),):ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favPlates.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 210,
                    ),
                    itemBuilder: (context, index) {
                      final item = favPlates[index];
                      return Stack(
                        children: [
                          EcommerceElement.categoryCard(
                            image: item.plateImageUrl1,
                            imageBoxFit: BoxFit.contain,
                            description: item.plateDescription,
                            title: item.plateName,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductPage2(plateItem: item),
                              ),
                            ),
                          ).box.make(),
                          IconButton(
                            onPressed: (){
                              provider.removeFavPlates(context.read<AuthProvider>().pb,index);},
                            icon: const Icon(Icons.favorite,color: Colors.redAccent,),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
