import 'kayitliKart.dart';
import 'siparis.dart';

import '../services/calculator.dart';
import 'adres.dart';

class Musteri {
  final String uid;
  String adSoyad;
  String cinsiyet;
  DateTime dogumTarihi;
  String mail;
//*firestore tarafında string array seçmeme rağmen bu tarafta karşılarken dynamic yapmazsam takılıyor. Ancak dynamic ile karşılıyor. 
  Map<String, dynamic> telefon;
  List<dynamic> favoriler; //Ürün idsini tutacak liste.
  List<dynamic> sepettekiUrunler; //Ürün idsini tutacak liste.
  List<dynamic> tiklananUrunler; //Ürün idsini tutacak liste.
  List<Adres> adres;
  List<KayitliKart> kayitliKart;
  List<Siparis> siparis;
  List<dynamic> aramaGecmisi;

  Musteri({
    required this.aramaGecmisi,
    required this.uid,
    required this.adSoyad,
    required this.cinsiyet,
    required this.dogumTarihi,
    required this.favoriler,
    required this.mail,
    required this.sepettekiUrunler,
    required this.telefon,
    required this.tiklananUrunler,
    required this.adres,
  required this.kayitliKart,
    required this.siparis
  });

  Map<String, dynamic> toMap() {
    /* List<Map<String, dynamic>> favoriler =
        this.favoriler.map((favoriUrunler) => favoriUrunler.toMap()).toList();

    List<Map<String, dynamic>> sepettekiUrunler = this
        .sepettekiUrunler
        .map((sepettekiUrunler) => sepettekiUrunler.toMap())
        .toList();

    List<Map<String, dynamic>> tiklananUrunler = this
        .tiklananUrunler
        .map((tiklananUrunler) => tiklananUrunler.toMap())
        .toList(); */

    /*  List<Map<String, dynamic>> adres =
        this.adres.map((adres) => adres.toMap()).toList(); */

    /* List<Map<String, dynamic>> kayitliKart = this
        .kayitliKart
        .map((kayitliKartlar) => kayitliKartlar.toMap())
        .toList();

    List<Map<String, dynamic>> siparis =
        this.siparis.map((siparisler) => siparisler.toMap()).toList(); */

    return {
      'uid': uid,
      'adSoyad': adSoyad,
      'cinsiyet': cinsiyet,
      'dogumTarihi': Calculator.datetimeToTimestamp(dogumTarihi),
      'favoriler': favoriler,
      'mail': mail,
      'sepettekiUrunler': sepettekiUrunler,
      'telefon': telefon,
      'tiklananUrunler': tiklananUrunler,
      'adres': adres,
      'kayitliKart': kayitliKart,
      'siparis': siparis,
      'aramaGecmisi': aramaGecmisi,
    };
  }

  factory Musteri.fromMap(Map<String, dynamic> map) {
    /*  var favorilerAsMap = map['favoriler'] as List;
    List<Urun> favoriler = favorilerAsMap
        .map((favorilerAsMap) => Urun.fromMap(favorilerAsMap))
        .toList();

    var sepettekiUrunlerAsMap = map['sepettekiUrunler'] as List;
    List<Urun> sepettekiUrunler = sepettekiUrunlerAsMap
        .map((sepettekiUrunlerAsMap) => Urun.fromMap(sepettekiUrunlerAsMap))
        .toList();

    var tiklananUrunlerAsMap = map['tiklananUrunler'] as List;
    List<Urun> tiklananUrunler = tiklananUrunlerAsMap
        .map((tiklananUrunlerAsMap) => Urun.fromMap(tiklananUrunlerAsMap))
        .toList(); */

    var adresAsMap = map['adres'] as List;
    List<Adres> adres =
        adresAsMap.map((adresAsMap) => Adres.fromMap(adresAsMap)).toList();
    //print('adres bilgisi: ${adres[0].adresIsmi}');

    var kayitliKartAsMap = map['kayitliKart'] as List;
    List<KayitliKart> kayitliKart = kayitliKartAsMap
        .map((kayitliKartAsMap) => KayitliKart.fromMap(kayitliKartAsMap))
        .toList();
    //print(kayitliKart);

    var siparisAsMap = map['siparis'] as List;
    List<Siparis> siparis = siparisAsMap
        .map((siparisAsMap) => Siparis.fromMap(siparisAsMap))
        .toList();
    //print(siparis);
    return Musteri(
        uid: map['uid'],
        adSoyad: map['adSoyad'],
        cinsiyet: map['cinsiyet'],
        dogumTarihi: Calculator.datetimeFromTimestamp(map['dogumTarihi']),
        favoriler: map['favoriler'],
        mail: map['mail'],
        sepettekiUrunler: map['sepettekiUrunler'],
        telefon: map['telefon'],
        tiklananUrunler: map['tiklananUrunler'],
        adres: adres,
        kayitliKart: kayitliKart,
        siparis: siparis,
        aramaGecmisi: map['aramaGecmisi']);
  }
}
