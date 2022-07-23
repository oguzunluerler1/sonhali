//todo BURADA CHAT VARİ BİR SİSTEM YAPMAMIZ LAZIM. SORU CEVAP ŞEKLİNDE.

import 'musteri.dart';

class Soru {
  final Musteri soruSahibi;
  final String soruMetni;

  Soru({required this.soruSahibi, required this.soruMetni});

  Map<String, dynamic> toMap() => {
        'soruSahibi': soruSahibi,
        'soruMetni': soruMetni,
      };

  factory Soru.fromMap(Map map) => Soru(
        soruSahibi: map['soruSahibi'],
        soruMetni: map['soruMetni'],
      );
}
