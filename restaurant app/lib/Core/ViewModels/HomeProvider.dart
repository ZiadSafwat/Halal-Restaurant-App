import 'dart:convert';
import 'package:ecommerce/Core/Models/BannerModel.dart';
import 'package:ecommerce/Core/Models/BestMeal.dart';
import 'package:ecommerce/Core/Models/PlatesModel.dart' as p;
import 'package:flutter/material.dart';
import 'package:mika_treeview/mika_treeview.dart';
import 'package:pocketbase/pocketbase.dart';

import '../Const/constant.dart';
import '../Models/IngredientsModel.dart';

class HomePageProvider extends ChangeNotifier {
  bool isPlatesLoading = false;
  bool isBannerLoading = false;
  bool isFiltering = false;
  bool isBestMealDealsLoading = false;
  List<Meal>? bestMealList = [];
  List<BannerItem> staticBannerList = [];
  List<BannerItem> sliderBannerList = [];
  List<p.Plate>? mostSealedPlateList = [];
  List<p.Plate> filteredPlateList = [];
  List<Meal> filteredMealList = [];
  Tree tree = Tree(nodes: [
    Node(id: '1', name: 'Plates Category', children: [
      Node(id: '2', name: 'Appetizer'),
      Node(id: '3', name: 'Main Course'),
      Node(id: '4', name: 'Dessert'),
      Node(id: '5', name: 'Beverage'),
      Node(id: '6', name: 'Side Dish'),
    ]),
  ]);
  List<String> filterSelectedNames = [];
  Set<String> filterSelectedItems = {};
  String searchText='';
  setFilterData(List<String> dataNames, Set<String> data, PocketBase pb,String search) {
    filterSelectedItems = data;
    filterSelectedNames = dataNames;searchText=search;
    getFilteredPlatesSell(pb, dataNames,searchText);
    notifyListeners();
  }
searchMeal( PocketBase pb,String search){
  searchText=search;
  getFilteredMeals(pb,searchText);
  notifyListeners();
}
clearFilter(){
  searchText='';
  filterSelectedNames = [];
  filterSelectedItems = {};
  notifyListeners();
}
  Future<void> getTreeFilter(PocketBase pb) async {
    try {
      final records = await pb.collection('ingredients').getFullList();

      List<Node> ingList = records.map((record) {
        var ingItem = Ingrediant.fromJson(jsonEncode(record.toJson()));
        return Node(id: ingItem.id, name: ingItem.name);
      }).toList();

      tree.nodes
          .add(Node(id: 'Ingrediant', name: 'Ingrediant', children: ingList));
    } catch (e) {
      debugPrint('Error fetching ingredients: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeFavPlates(PocketBase pb,int index) async {
    try {



      final body = <String, dynamic>{
        "plates-":   mostSealedPlateList![index].id,
      };

      final record = await pb.collection('My_Favorites').update(mostSealedPlateList![index].favId!, body: body).then((value) {
        mostSealedPlateList![index].isFav=false;
      },);


    } catch (e) {

      debugPrint('Error fetching plates: $e');
    } finally {
      notifyListeners();
    }
  }
    refreshData(PocketBase pb) async {
    await Future.wait([
      getBestMealDeals(pb),
      getBannerList(pb),
      getMostPlatesSell(pb),
      getTreeFilter(pb)
    ]);
  }

  Future<void> getMostPlatesSell(PocketBase pb) async {
    try {
      isPlatesLoading = true;
      notifyListeners();
print(pb.authStore.record!.id);
      final records = await pb.send("/api/plateso/${pb.authStore.record!.id}", );
     // final  = res.data; // or jsonDecode(res.body), depending on your setup

      mostSealedPlateList = (records as List)
          .map((record) => p.Plate.fromMap(record))
          .toList();
    } catch (e, n) {
      mostSealedPlateList = null;
      debugPrint('Error fetching plates: $e\n$n');
    } finally {
      isPlatesLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFilteredPlatesSell(PocketBase pb, List<String> filters, String searchText) async {
    try {
      isFiltering = true;
      notifyListeners();

      // Constructing the query parameters map
      Map<String, dynamic> queryParams = {};

      // Adding filters as a comma-separated string
      if (filters.isNotEmpty) {
        queryParams['filters'] = filters.join(',');
      }

      // Adding search condition if search text is provided
      if (searchText.isNotEmpty) {
        queryParams['search'] = searchText;
      }

      // Sending the request to the custom route
      final records = await pb.send(
        "/api/plateso/${pb.authStore.record!.id}",
        query: queryParams,
      );

      // Processing the response and converting it to a list of Plates
      filteredPlateList =(records as List)
          .map((record) => p.Plate.fromMap(record))
          .toList();

    } catch (e) {
      filteredPlateList = [];
      debugPrint('Error fetching plates: $e');
    } finally {
      isFiltering = false;
      notifyListeners();
    }
  }
  Future<void> getFilteredMeals(PocketBase pb, String searchText) async {
    try {
      isFiltering = true;
      notifyListeners();
      // Constructing the filter expression for searching meals
      String filterExpression = searchText.isNotEmpty
          ? 'meal_name ?~ {:search} || meal_description ?~ {:search}'
          : '';

      // Constructing the parameters map
      Map<String, dynamic> params = {};
      if (searchText.isNotEmpty) {
        params['search'] = searchText;
      }

      final records = await pb.collection('viewMeal').getFullList(

        filter: pb.filter(filterExpression, params),
      );


      filteredMealList = records
          .map((record) => Meal.fromJson(jsonEncode(record.toJson())))
          .toList();
    } catch (e) {
      filteredMealList = [];
      debugPrint('Error fetching filtered meals: $e');
    } finally {
      isFiltering = false;
      notifyListeners();
    }
  }

  Future<void> getBestMealDeals(PocketBase pb) async {
    try {
      isBestMealDealsLoading = true;
      notifyListeners();
      final records =
          await pb.collection('viewMeal').getFullList(sort: '-discount');
      bestMealList = records
          .map((record) => Meal.fromJson(jsonEncode(record.toJson())))
          .toList();
    } catch (e) {
      bestMealList = null;
      debugPrint('Error fetching best meals: $e');
    } finally {
      isBestMealDealsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBannerList(PocketBase pb) async {
    try {
      isBannerLoading = true;
      notifyListeners();
      final records = await pb.collection('Banner').getFullList();
      List<BannerItem> bannerList = records.map((record) {
        var bannerItem = BannerItem.fromJson(jsonEncode(record.toJson()));
        if (bannerItem.image != null) {
          bannerItem.image =
              "${AppConstants.baseUrl}/api/files/Banner/${record.id}/${bannerItem.image}";
        }
        return bannerItem;
      }).toList();
      staticBannerList =
          bannerList.where((element) => !element.isSlider!).toList();
      sliderBannerList =
          bannerList.where((element) => element.isSlider!).toList();
    } catch (e) {
      staticBannerList = [];
      sliderBannerList = [];
      debugPrint('Error fetching banners: $e');
    } finally {
      isBannerLoading = false;
      notifyListeners();
    }
  }
}
