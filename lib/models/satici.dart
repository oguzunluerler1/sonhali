import 'adres.dart';

class Satici {
  final String adSoyad;
  final Adres adres;
  final String magazaAdi;
  final String mail;
  final String sirketAdi;
  final Map<String, String> telefon;

  Satici(
      {required this.adSoyad,
      required this.adres,
      required this.magazaAdi,
      required this.mail,
      required this.sirketAdi,
      required this.telefon});

  Map<String, dynamic> toMap() => {
        'adSoyad': adSoyad,
        'adres': adres,
        'magazaAdi': magazaAdi,
        'mail': mail,
        'sirketAdi': sirketAdi,
        'telefon': telefon,
      };

  factory Satici.fromMap(Map map) => Satici(
        adSoyad: map['adSoyad'],
        adres: map['adres'],
        magazaAdi: map['magazaAdi'],
        mail: map['mail'],
        sirketAdi: map['sirketAdi'],
        telefon: map['telefon'],
      );
}
