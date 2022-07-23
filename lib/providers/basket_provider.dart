import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:idea_ecommerce_app/models/urun.dart';
import '../services/auth.dart';

class BasketProvider extends ChangeNotifier {
    List<Urun> _sepettekiUrunler = [];
    List<int> _productsAmounts = [];
    List _sepettekiIds = [];
    Auth _auth = Auth();

    List<Urun> get sepet => _sepettekiUrunler;
    List<int> get amount => _productsAmounts;

  Future<void> getBasket() async {
    var uid = _auth.onlineUser()?.uid;
    var response = await FirebaseFirestore.instance.collection("Customer").doc(uid).get().then((value) => value.data()?["sepettekiUrunler"]);
    _sepettekiIds = response;

    var responseProduct = await FirebaseFirestore.instance.collection("Product").get();
    var data = responseProduct.docs.map((e) => e.data()).toList();

    _sepettekiUrunler = data.map((e) => Urun.fromMap(e)).toList().where((element) => _sepettekiIds.contains(element.id)).toList();
    for (var element in _sepettekiUrunler) {
      print(element.isim);
    }
    _productsAmounts.clear();
    for (var i = 0; i < _sepettekiUrunler.length; i++) {
      int amount = _sepettekiIds.where((element) => element == _sepettekiUrunler[i].id).length;
      _productsAmounts.add(amount);
    }
    print(_productsAmounts);

    notifyListeners();
  }

  Future<void> addItemToBasket(Urun urun) async {
    _sepettekiIds.add(urun.id);
    Map<String, dynamic> updateBasketList = {
      "sepettekiUrunler":_sepettekiIds
    };
    var uid = _auth.onlineUser()?.uid;
    await FirebaseFirestore.instance.collection("Customer").doc(uid).update(updateBasketList);
  }  
  
  Future<void> removeItemToBasket(Urun urun) async {
    _sepettekiIds.remove(urun.id);
    Map<String, dynamic> updateBasketList = {
      "sepettekiUrunler":_sepettekiIds
    };
    var uid = _auth.onlineUser()?.uid;
    await FirebaseFirestore.instance.collection("Customer").doc(uid).update(updateBasketList);
  }

  Future<void> sepetiBosalt() async {
    Map<String, dynamic> updateBasketList = {
      "sepettekiUrunler": []
    };
    var uid = _auth.onlineUser()?.uid;
    await FirebaseFirestore.instance.collection("Customer").doc(uid).update(updateBasketList);
  }
}