class Admin {
  final String id;
  final String adSoyad;
  final String telefon;
  final String mail;

  Admin(
      {required this.id,
      required this.adSoyad,
      required this.telefon,
      required this.mail});

  Map<String, dynamic> toMap() =>
      {'id': id, 'adSoyad': adSoyad, 'telefon': telefon, 'mail': mail};

  factory Admin.fromMap(Map map) => Admin(
      id: map['id'],
      adSoyad: map['adSoyad'],
      telefon: map['telefon'],
      mail: map['mail']);
}
