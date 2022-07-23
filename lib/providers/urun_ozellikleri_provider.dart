import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/urun.dart';
import '../services/auth.dart';

class UrunOzellikleriProvider {
  Auth _auth = Auth();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  musteriBilgisi() {
    String? uid = _auth.onlineUser()?.uid;
    return uid;
  }

  Future<String> urunAciklamalari(Urun urun) async {
    var urunBilgisi = await _firestore
        .collection('Product')
        .doc(urun.id)
        .get()
        .then((value) => value.data());

    String urunAciklamalari = urunBilgisi?['urunAciklamasi'];

    return urunAciklamalari;
  }

  Future<String> urunOzellikleri(Urun urun) async {
    var urunBilgisi = await _firestore
        .collection('Product')
        .doc(urun.id)
        .get()
        .then((value) => value.data());

    String urunOzellikleri = urunBilgisi?['urunOzellikleri'];

    return urunOzellikleri;
  }
}
