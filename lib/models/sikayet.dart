import '../services/calculator.dart';

class Sikayet {
  final sikayetSahibi;
  final String sikayetKonusu;
  final DateTime sikayetTarihi;

  Sikayet(
      {required this.sikayetSahibi,
      required this.sikayetKonusu,
      required this.sikayetTarihi});

  Map<String, dynamic> toMap() => {
        'sikayetSahibi': sikayetSahibi,
        'sikayetKonusu': sikayetKonusu,
        'sikayetTarihi': Calculator.datetimeToTimestamp(sikayetTarihi),
      };

  factory Sikayet.fromMap(Map map) => Sikayet(
        sikayetSahibi: map['sikayetSahibi'],
        sikayetKonusu: map['sikayetKonusu'],
        sikayetTarihi: Calculator.datetimeFromTimestamp(map['magazaAdi']),
      );
}
