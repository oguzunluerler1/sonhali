//todo ÖDEME YÖNTEMLERİ ÜZERİNE ARAŞTIRMA YAPMAK LAZIM. BAYA KAPSAMLI BİR KONU KISA BAKTIM AMA TAM ANLAYAMADIM.

class KayitliKart {
  final String id;
  final String kartNumarasi;
  final String cvc;
  final DateTime sonKullanmaTarihi;
  final String isim;

  KayitliKart(
      {required this.sonKullanmaTarihi,
      required this.id,
      required this.kartNumarasi,
      required this.cvc,
      required this.isim});

  Map<String, dynamic> toMap() => {
        'id': id,
        'kartNumarasi': kartNumarasi,
        'cvc': cvc,
        'sonKullanmaTarihi': sonKullanmaTarihi,
        'isim': isim,
      };

  factory KayitliKart.fromMap(Map map) => KayitliKart(
      id: map['id'],
      kartNumarasi: map['kartNumarasi'],
      cvc: map['cvc'],
      sonKullanmaTarihi: map['sonKullanmaTarihi'],
      isim: map['isim']);
}
