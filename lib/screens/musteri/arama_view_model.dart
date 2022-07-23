import '../../models/urun.dart';
import '../../services/auth.dart';
import '../../services/database.dart';

class AramaViewModel {
  Database _database = Database();
  Auth _auth = Auth();

  

  Future<List<dynamic>> gecmisBilgisi() async {
    String? uid = _auth.onlineUser()?.uid;

    Map<String, dynamic>? musteriBilgisiMap =
        await _database.musteriVerisiCekme(uid);

    var data = await _database.gecmisBilgisi(
        path: 'Customer', uid: musteriBilgisiMap!['uid']);

    var gecmis = data.data()!['aramaGecmisi'];

    return gecmis;
  }

  Future<List<Urun>> arama(String value) async {
    var data = await _database.arama(value: value, path: 'Product');
    List<Urun> docSnap = data.docs.map((e) => Urun.fromMap(e.data())).toList();
    return docSnap;
  }
}
