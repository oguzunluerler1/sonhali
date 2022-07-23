import '../services/calculator.dart';
import 'urun.dart';

class Siparis {
  final String id;
  final DateTime siparisTarihi;
  final List<Urun> urunler;

  Siparis(
      {required this.id, required this.siparisTarihi, required this.urunler});

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> urunler =
        this.urunler.map((urunler) => urunler.toMap()).toList();

    return {
      'id': id,
      'urunler': urunler,
      'siparisTarihi': Calculator.datetimeToTimestamp(siparisTarihi),
    };
  }

  factory Siparis.fromMap(Map map) {
    var urunlerAsMap = map['Product'] as List;
    List<Urun> urunler =
        urunlerAsMap.map((urunlerAsMap) => Urun.fromMap(urunlerAsMap)).toList();

    return Siparis(
      id: map['id'],
      urunler: urunler,
      siparisTarihi: Calculator.datetimeFromTimestamp(map['siparisTarihi']),
    );
  }
}
