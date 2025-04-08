import 'package:ecommerce/Core/Models/BestMeal.dart' as meal;
import 'package:ecommerce/Core/Models/PlatesModel.dart' as plate;
import 'package:ecommerce/Core/ViewModels/AuthProvider.dart';
import 'package:ecommerce/Core/ViewModels/HomeProvider.dart';
import 'package:ecommerce/View/Screens/loadinIndicator.dart';
import 'package:ecommerce/View/Screens/productView/ProductPage2.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Components/ecommerce_kit/src/ecommerce_kit.dart';
import '../drawer/FilterDrawer.dart';
import '../productView/ProductPage.dart';
import 'package:provider/provider.dart';

class ItemsPreview1 extends StatelessWidget {
  ItemsPreview1({super.key, required this.title,  });

  final String title;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  List<meal.Meal> getCorrectList(HomePageProvider provider) {
    return provider.searchText.isNotEmpty ? provider.filteredMealList : provider.bestMealList ?? [];
  }

  @override
  Widget build(BuildContext context) {
 //   double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFF24D18),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      drawer: const FilterDrawer(),
      body: Consumer<HomePageProvider>(
        builder: (context, provider, _) {
          final filteredList = getCorrectList(provider);
          _searchController.text = provider.searchText;

          return SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SearchBar(
                    controller: _searchController,
                    onChanged: (value) {
                      if(value.isEmpty) {
                      final auth = context.read<AuthProvider>();
                      provider.searchMeal(auth.pb, value);}
                    },onSubmitted: (value) {
                    final auth = context.read<AuthProvider>();
                    provider.searchMeal(auth.pb, value);
                  },
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    overlayColor: const WidgetStatePropertyAll(Colors.white),
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final auth = context.read<AuthProvider>();
                          provider.searchMeal(auth.pb, _searchController.text);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.highlight_remove),
                        onPressed: provider.clearFilter,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 210,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return EcommerceElement.categoryCard(
                        image: item.image,
                        imageBoxFit: BoxFit.contain,
                        description: item.mealDescription,
                        title: item.mealName,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductPage(meal: item),
                          ),
                        ),
                      ).box.make();
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


class ItemsPreview2 extends StatelessWidget {
  ItemsPreview2({super.key, required this.title, });

  final String title;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  List<plate.Plate> getCorrectList(HomePageProvider provider) {
    return provider.filterSelectedNames.isNotEmpty || provider.searchText.isNotEmpty
        ? provider.filteredPlateList
        : provider.mostSealedPlateList ?? [];
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              icon: const Icon(Icons.filter_list_alt),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      drawer: const FilterDrawer(),
      body: IceCreamIndicator(
        onRefresh: () async {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          final homeProvider = Provider.of<HomePageProvider>(context, listen: false);
          await homeProvider.getFilteredPlatesSell(authProvider.pb,homeProvider.filterSelectedNames,homeProvider.searchText);
        },
        child: Consumer<HomePageProvider>(
          builder: (context, provider, _) {
            final filteredList = getCorrectList(provider);
            _searchController.text = provider.searchText;

            return SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: SearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        if(value.isEmpty) {
                          final auth = context.read<AuthProvider>();
                          provider.setFilterData(
                            provider.filterSelectedNames,
                            provider.filterSelectedItems,
                            auth.pb,
                            value,
                          );
                        }
                      },
                      onSubmitted: (value) {
                        final auth = context.read<AuthProvider>();
                        provider.setFilterData(
                          provider.filterSelectedNames,
                          provider.filterSelectedItems,
                          auth.pb,
                          value,
                        );
                      },
                      backgroundColor: const WidgetStatePropertyAll(Colors.white),
                      overlayColor: const WidgetStatePropertyAll(Colors.white),
                      trailing: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            final auth = context.read<AuthProvider>();
                            provider.setFilterData(
                              provider.filterSelectedNames,
                              provider.filterSelectedItems,
                              auth.pb,
                              _searchController.text,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.highlight_remove),
                          onPressed: provider.clearFilter,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 210,
                      ),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return EcommerceElement.categoryCard(
                          image: item.plateImageUrl1,
                          imageBoxFit: BoxFit.contain,
                          description: item.plateDescription,
                          title: item.plateName,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductPage2(plateItem: item),
                            ),
                          ),
                        ).box.make();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

