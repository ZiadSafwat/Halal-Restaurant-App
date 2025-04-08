import 'dart:convert';
import 'package:ecommerce/Core/Models/PlatesModel.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:velocity_x/velocity_x.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Plate> _favoritePlates = [];
  String collectionId='';
  bool isFavLoading = false;
  List<Plate> get favoritePlates => _favoritePlates;
  List<String> get favoritePlatesIds => _favoritePlates.generate((index) {
    return _favoritePlates[index].id;
  },).toList();

  void setFavoritePlates(List<Plate> plates) {
    _favoritePlates = plates;
    notifyListeners();
  }
  Future<void> getFavPlates(PocketBase pb) async {
    try {
      isFavLoading = true;
      notifyListeners();

      final records = await pb.send("/api/plateso/${pb.authStore.record!.id}", query: {'favoritesOnly':true});
      // final  = res.data; // or jsonDecode(res.body), depending on your setup

      _favoritePlates = (records as List)
          .map((record) => Plate.fromMap(record))
          .toList();
    } catch (e, n) {
      _favoritePlates = [];
      debugPrint('Error fetching plates: $e\n$n');
    } finally {
      isFavLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeFavPlates(PocketBase pb,int index) async {
    try {
      isFavLoading = true;
      notifyListeners();

      final body = <String, dynamic>{
        "plates-": favoritePlates[index].id,
      };

      final record = await pb.collection('My_Favorites').update(collectionId, body: body).then((value) {
       favoritePlates.removeAt(index);
      },);


    } catch (e) {

      debugPrint('Error fetching plates: $e');
    } finally {
      isFavLoading = false;
      notifyListeners();
    }
  }

}
