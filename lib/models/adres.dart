class Adres {
  final String adresIsmi;
  final String apartman;
  final String cadde;
  final String daireNo;
  final String duzMetin;
  final String il;
  final String ilce;
  final String katBlok;
  final String mahalle;
  final String sokak;

  Adres(
      {required this.adresIsmi,
      required this.apartman,
      required this.cadde,
      required this.daireNo,
      required this.duzMetin,
      required this.il,
      required this.ilce,
      required this.katBlok,
      required this.mahalle,
      required this.sokak});

  Map<String, dynamic> toMap() => {
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

  factory Adres.fromMap(Map map) => Adres(
      adresIsmi: map['adresIsmi'],
      apartman: map['apartman'],
      cadde: map['cadde'],
      daireNo: map['daireNo'],
      duzMetin: map['duzMetin'],
      il: map['il'],
      ilce: map['ilce'],
      katBlok: map['katBlok'],
      mahalle: map['mahalle'],
      sokak: map['sokak']);
}
