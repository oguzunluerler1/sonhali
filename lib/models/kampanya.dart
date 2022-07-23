class Kampanya {
  final String id;
  final String kapsami;
  final String ozelligi;
  final List<String> tanitimResmiUrl;

  Kampanya(
      {required this.tanitimResmiUrl,
      required this.id,
      required this.kapsami,
      required this.ozelligi});

  Map<String, dynamic> toMap() => {
        'id': id,
        'kapsami': kapsami,
        'ozelligi': ozelligi,
        'tanitimResmi': tanitimResmiUrl,
      };

  factory Kampanya.fromMap(Map map) => Kampanya(
      id: map['id'],
      kapsami: map['kapsami'],
      ozelligi: map['ozelligi'],
      tanitimResmiUrl: map['tanitimResmi']);
}
