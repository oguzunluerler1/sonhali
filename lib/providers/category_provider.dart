import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {

  List<String> _categoryNames = [];
  List<Map<String,dynamic>> _categoryDetails = [];

  List<String> get getCategories => _categoryNames;
  List<Map<String,dynamic>> get getCategoryDetailMap => _categoryDetails;

  Future<void> getAllCategories() async {
    var response = await FirebaseFirestore.instance.collection("Kategoriler").get();
    _categoryNames = response.docs.map((e) => e.id).toList();
    await getCategoryDetail();
    notifyListeners();
  }  
  
  Future<void> getCategoryDetail() async {
    for (var item in _categoryNames) {
      var response = await FirebaseFirestore.instance
        .collection("Kategoriler")
        .doc(item)
        .get()
        .then((value) => value.data());
      _categoryDetails.add(response!);
    }
    notifyListeners();
  }

}