import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth.dart';
class YeniAdresOlusturProvider {
  Auth _auth = Auth();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  musteriBilgisi() {
    String? uid = _auth.onlineUser()?.uid;
    return uid;
  }

  musteriyeAdresEkleme(
      {required String adresIsmi,
      required String apartman,
      required String cadde,
      required String daireNo,
      required String duzMetin,
      required String il,
      required String ilce,
      required String katBlok,
      required String mahalle,
      required String sokak}) async {
    String musteriUid = musteriBilgisi();
    Map eklenecekAdres = {
      'adresIsmi': adresIsmi,
      'apartman': apartman,
      'cadde': cadde,
      'daireNo': daireNo,
      'duzMetin': duzMetin,
      'il': il,
      'ilce': ilce,
      'katBlok': katBlok,
      'mahalle': mahalle,
      'sokak': sokak,
    };
    var musteriDatabaseVerisi = await _firestore
        .collection('Customer')
        .doc(musteriUid)
        .get()
        .then((value) => value.data());

    var list = musteriDatabaseVerisi?['adres'] as List;
    list.add(eklenecekAdres);
    _firestore
        .collection('Customer')
        .doc(musteriUid)
        .set(musteriDatabaseVerisi!);
  }
}
