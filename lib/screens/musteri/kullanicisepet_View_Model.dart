import '../../services/database.dart';

import '../../models/musteri.dart';
import '../../models/urun.dart';
import '../../services/auth.dart';

class KullaniciSepetViewModel {
  final _auth = Auth();
  final _database = Database();

  Future<List<Urun>> sepetUrunVerisiOkuma() async {
    String? uid = await _auth.onlineUser()?.uid;
    //print('musteri uid $uid');
    Map<String, dynamic>? musteriBilgisiMap =
        await _database.musteriVerisiCekme(uid);
    //print('musterimap $musteriBilgisiMap');
    //*HALLETTİM. burada databaseden çektiğim müşteri bilgilerini içeren mapi müşteriye çevirip onun üzerinden işlem yapacaktım ama hata vermiyor ama müşteri nesnesi de oluşmuyor çözemedim bir türlü. O yüzden şimdilik direk mapden aldığım bilgiyi kullanıyorum.
    Musteri musteriBilgisi = Musteri.fromMap(musteriBilgisiMap!);
    //print(musteriBilgisi.adSoyad);

    var data = await _database.sepetUrunVerisiOkuma(
        path: 'Product', urun: musteriBilgisi.sepettekiUrunler);

    List<Urun> docSnap = data.docs.map((e) => Urun.fromMap(e.data())).toList();

    return docSnap;
  }
}
