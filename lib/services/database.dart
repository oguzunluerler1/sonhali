import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/musteri.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  sepeteUrunEkleme(String path, String docId, String uid) async {
    var musteriBilgisi = await _firestore
        .collection(path)
        .doc(uid)
        .get()
        .then((value) => value.data());
    List sepettekiUrunler = musteriBilgisi?['sepettekiUrunler'];

    if (!sepettekiUrunler.contains(docId)) {
      sepettekiUrunler.add(docId);
    }

    musteriBilgisi?['sepettekiUrunler'] = sepettekiUrunler;
    //print(musteriBilgisi?['sepettekiUrunler']);
    await _firestore.collection(path).doc(uid).set(musteriBilgisi!);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> sepetUrunVerisiOkuma(
      {required String path, required List urun}) async {
    var data = await _firestore.collection(path);
    //.where('id', whereIn: urun);  
    return data.get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> arama(
      {required String path, required String value}) async {
    var data =
        await _firestore.collection(path).where('isim', isEqualTo: value);
    return await data.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> gecmisBilgisi(
      {required String path, required String uid}) async {
    var data = await _firestore.collection(path).doc(uid).get();
    return data;
  }

  Future<Map<String, dynamic>?> musteriVerisiCekme(String? uid) async {
    var musteriVerisi = await _firestore.collection('Customer').doc(uid).get();

    return musteriVerisi.data();
  }

  userEkleme({required String uid, required String mail}) async {
    Map<String, dynamic> _eklenecekMusteri = Musteri(
        uid: uid,
        adSoyad: ' ',
        adres: [],
        cinsiyet: ' ',
        favoriler: [],
        mail: mail,
        tiklananUrunler: [],
        telefon: {},
        sepettekiUrunler: [],
        dogumTarihi: DateTime.parse('1900-01-01 00:00:00Z'),
        kayitliKart: [],
        siparis: [],
        aramaGecmisi: []).toMap();

    //print(_eklenecekMusteri);
    /* Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['uid'] = uid;
    _eklenecekUser['mail'] = mail; */
//*Burada .doc() diyerek document adını kendimiz belirliyoruz. Yoksa kendisi uniqe bir ad tanımlıyor. uid diyerek de auth tarafından oluşturulan user idyi vermiş olduk. set ile de map vererek girilecek verileri girdik. doc adı ile uid aynı olması karışıklık yaratmaması açısından çok mantıklı oldu bence.
    await _firestore.collection('Customer').doc(uid).set(_eklenecekMusteri);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> tiklananUrunVerisiOkuma(
      {required String path, required List urun}) async {
    var data = await _firestore
        .collection(path);
        //.where('id', whereIn: urun); //todo: asdas

    return data.get();
  }

  veriEklemeAdd() async {
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['adSoyad'] = 'Tuğçe Burkay';
    _eklenecekUser['cinsiyet'] = "kadın";
    _eklenecekUser['adres'] = {'il': 'ankara', 'ilce': 'yenimahalle'};
    _eklenecekUser['renkler'] = FieldValue.arrayUnion(['mavi', 'yeşil']);
    _eklenecekUser['createdAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('Customer').add(_eklenecekUser);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> tumUrunVerisiOkuma(
      String path) async {
    var data = await _firestore.collection(path).get();

    return data;
  }

  /* Future<int> urunSayisi() async {
    var products = await _firestore.collection("Product").get();
    return products.docs.length;
  } */
}
