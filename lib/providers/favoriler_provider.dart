import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/urun.dart';

import '../services/auth.dart';

class FavorilerProvider extends ChangeNotifier {
  List<Urun> _favoriUrunler = [];
  List _favoritedProductIds = [];

  Auth _auth = Auth();

  List<Urun> get getfavoriUrunler => _favoriUrunler;

  bool getProductInListValue(Urun urun) {
    bool urunListedeMi = _favoriUrunler.any((element) => element.id == urun.id);
   
    return urunListedeMi;
  }

  Future<void> getFavorites() async {
    var uid = _auth.onlineUser()?.uid;
    var response = await FirebaseFirestore.instance.collection("Customer").doc(uid).get().then((value) => value.data()?["favoriler"]);
    _favoritedProductIds = response;
    await _getFavoriteProducts(_favoritedProductIds);
    notifyListeners();
  }

  Future<void> _getFavoriteProducts(List favoritedProductIds) async {
    var response = await FirebaseFirestore.instance.collection("Product").get();
    var data = response.docs.map((e) => e.data()).toList();
    _favoriUrunler = data
        .map((e) => Urun.fromMap(e))
        .toList()
        .where((element) => favoritedProductIds.contains(element.id))
        .toList();
    for (var element in _favoriUrunler) {
      print(element.isim);
    }
  }

  Future<void> clickToUpdateFavorite(Urun urun) async {
    if (_favoritedProductIds.any((e) => e == urun.id)) {
      _favoritedProductIds.remove(urun.id);
    } else {
      _favoritedProductIds.add(urun.id);
    }
    Map<String, dynamic> updateFavoriteList = {
      "favoriler": _favoritedProductIds
    };

    var uid = _auth.onlineUser()?.uid;
    await FirebaseFirestore.instance
        .collection("Customer")
        .doc(uid)
        .update(updateFavoriteList);
  }
}
