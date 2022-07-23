

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/adres.dart';
import '../services/auth.dart';

class AdreslerimProvider {
  Auth _auth = Auth();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  musteriBilgisi() {
    String? uid = _auth.onlineUser()?.uid;
    return uid;
  }

  Future<List<Adres>> adresBilgisi() async {
    var musteriUid = musteriBilgisi();
    var musteriAdresBilgisi = await _firestore
        .collection('Customer')
        .doc(musteriUid)
        .get()
        .then((value) => value.data());
    var adres = musteriAdresBilgisi?['adres'] as List;
    List<Adres> adresListesi = adres.map((e) => Adres.fromMap(e)).toList();

    return adresListesi;
  }
}
