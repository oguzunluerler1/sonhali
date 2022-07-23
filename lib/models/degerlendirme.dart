import '../services/calculator.dart';

import 'urun.dart';

class Degerlendirme {
  final String yorum;
  final int puan;
  final DateTime tarih;
//*Resimleri storagedan URL ler üzerinden alıyoruz. Birden fazla resim olabileceği için list reference şeklinde belirledim.
  final List<String> resimUrl;
  final Urun urun;

  Degerlendirme({
    required this.yorum,
    required this.puan,
    required this.tarih,
    required this.urun,
    required this.resimUrl,
  });

  Map<String, dynamic> toMap() => {
        'yorum': yorum,
        'puan': puan,
        'tarih': Calculator.datetimeToTimestamp(tarih),
        'urun': urun,
        'resim': resimUrl,
      };

  factory Degerlendirme.fromMap(Map map) => Degerlendirme(
        yorum: map['yorum'],
        puan: map['puan'],
        tarih: Calculator.datetimeFromTimestamp(map['tarih']),
        urun: map['urun'],
        resimUrl: map['resim'],
      );
}
