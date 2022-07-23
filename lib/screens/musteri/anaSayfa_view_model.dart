import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/urun.dart';
import '../../services/database.dart';

import '../../models/musteri.dart';
import '../../services/auth.dart';

class AnasayfaViewModel extends ChangeNotifier {
  Database _database = Database();
  Auth _auth = Auth();

sepeteUrunEkleme(String docId) async {
    String? uid = await _auth.onlineUser()?.uid;
    _database.sepeteUrunEkleme('Customer', docId, uid!);
  }

  Future<List<Urun>> tiklananUrunVerisiOkuma() async {
    String? uid = _auth.onlineUser()?.uid;

    Map<String, dynamic>? musteriBilgisiMap =
        await _database.musteriVerisiCekme(uid);

    //*HALLETTİM. burada databaseden çektiğim müşteri bilgilerini içeren mapi müşteriye çevirip onun üzerinden işlem yapacaktım ama hata vermiyor ama müşteri nesnesi de oluşmuyor çözemedim bir türlü. O yüzden şimdilik direk mapden aldığım bilgiyi kullanıyorum.
    Musteri musteriBilgisi = Musteri.fromMap(musteriBilgisiMap!);

    var data = await _database.tiklananUrunVerisiOkuma(
        path: 'Product', urun: musteriBilgisi.tiklananUrunler);

    List<Urun> docSnap = data.docs.map((e) => Urun.fromMap(e.data())).toList();
    docSnap.shuffle();
    return docSnap;
  }

  veriEkleme() async {
    _database.veriEklemeAdd();
  }

  Future<List<Urun>> tumUrunVerisiOkuma() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _database.tumUrunVerisiOkuma('Product');
    //print(data);
    List<Urun> docSnap = data.docs.map((e) => Urun.fromMap(e.data())).toList();
    //print(docSnap);
    docSnap.shuffle();
    return docSnap;
  }

  /* Future<QuerySnapshot<Map<String, dynamic>>> veriOkuma() async {
    return _database.urunVerisiOkuma();
  } */

  /* Future<int> urunSayisi() async {
    return _database.urunSayisi();
  } */
}
