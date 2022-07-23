import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/favoriler_provider.dart';
import 'package:idea_ecommerce_app/screens/musteri/arama_view.dart';
import 'package:idea_ecommerce_app/screens/musteri/my_home_page.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ekrani_view.dart';
import 'package:idea_ecommerce_app/services/database.dart';
import 'package:idea_ecommerce_app/utilities/route_helper.dart';
import 'package:idea_ecommerce_app/widgets/add_basket_button.dart';
import 'package:provider/provider.dart';
import '../../models/urun.dart';

class secilmisKategoriScreen extends StatefulWidget {
  const secilmisKategoriScreen({Key? key, required this.title, required this.categoryId}) : super(key: key);
  final String title;
  final String categoryId;
  @override
  State<secilmisKategoriScreen> createState() => _secilmisKategoriScreenState();
}
  final key = GlobalKey<MyHomePageState>();

class _secilmisKategoriScreenState extends State<secilmisKategoriScreen> {


  List markaSecilenler = [];
  List filtreFiyatListesi = [
    {"min": 0, "max": 999999999},
    {"min": 0, "max": 50},
    {"min": 50, "max": 100},
    {"min": 100, "max": 200},
    {"min": 200, "max": 999999999},
  ];
  int secilmisFiyatOpt = 0;
  List<Urun> filtreList = [];
  int selectedValuePop = 1;
  bool isChecked = false;
  List<Urun> sepetUrunleri = [];
  List<Urun> favorilenmisUrunler = [];
  //üst silincek
  //

  List<Urun> products = [];
  List<Urun> tempProducts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSelectedProducts();
    });
  }

  void getSelectedProducts() async {
  QuerySnapshot<Map<String, dynamic>> data =
        await Database().tumUrunVerisiOkuma('Product');
    //print(data);
    List<Urun> docSnap = data.docs.map((e) => Urun.fromMap(e.data())).toList();
    tempProducts = docSnap.where((element) => element.kategoriId == widget.categoryId).toList();
    tempProducts.forEach((element) {print(element.isim);});
    products = tempProducts;
    favorilenmisUrunler = context.read<FavorilerProvider>().getfavoriUrunler;
    favorilenmisUrunler.forEach((element) {print(element.isim);});
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        actions: [
          GestureDetector(
              onTap: () {
                RouteHelper.goRoute(context: context, page: Arama());
              },
              child: Icon(
                Icons.search,
                color: Colors.purple,
              )),
          GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                await Future.delayed(Duration.zero,(){
                  key.currentState?.goToSelectedPage(4);
                });
              },
              child: Icon(
                Icons.person,
                color: Colors.purple,
              )),
        ],
        title: Text(
          "${widget.title} (${products.length})",
          style: TextStyle(color: Color.fromARGB(255, 152, 99, 161)),
        ),
      ),
      body: bodyMethod(),
    );
  }

  Widget bodyMethod() {
    return SingleChildScrollView(
      child: Column(
        children: [
          siralaFiltreleRowu(),
          gridMetodu(),
        ],
      ),
    );
  }

  GridView gridMetodu() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        Urun currentUrun = products[index];
        return InkWell(
          onTap: () {
            RouteHelper.goRoute(context: context, page: urunEkrani(currentUrun));
          },
          child: Card(
            color: Colors.primaries[index % 17].shade200,
            child: Column(
              children: [
                Expanded(child: FavoriIconu(currentUrun, index)),
                urunResimleri(index),
                Text("${products[index].isim}"),
                puanlamalarDegerlendirmesayisi(products[index]),
                fiyatlar(index),
                SepeteEkleMetod(index, context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget SepeteEkleMetod(int index, BuildContext context) {
    return AddBasketButton(urun: products[index]);
  }

  Expanded urunResimleri(int index) {
    return Expanded(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            products[index].urunResimleriUrl[0],
            fit: BoxFit.cover,
          ),
        ));
  }

  Expanded fiyatlar(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("${products[index].fiyat} TL")),
      ),
    );
  }

  Widget puanlamalarDegerlendirmesayisi(Urun urun) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Text("${urun.puanOrt} "),
          Row(
              children: List.generate(5, (index) {
            return Icon(
              index + 1 <= urun.puanOrt ? Icons.star : Icons.star_border,
              size: 18,
            );
          })),
          Expanded(
              flex: 2,
              child: Text("(${urun.degsayisi})")), 
          Spacer(),
        ],
      ),
    );
  }

  poplama() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                RadioListTile<int>(
                  value: 1,
                  groupValue: selectedValuePop,
                  onChanged: (value) {
                    setState(() {
                      selectedValuePop = value!;
                      siraYok();
                    });
                  },
                  title: Text("Sıralama Yok"),
                ),
                RadioListTile<int>(
                  value: 2,
                  groupValue: selectedValuePop,
                  onChanged: (value) {
                    setState(() {
                      selectedValuePop = value!;
                      artanSirala();
                    });
                  },
                  title: Text("Artan Fiyat"),
                ),
                RadioListTile<int>(
                  value: 3,
                  groupValue: selectedValuePop,
                  onChanged: (value) {
                    setState(() {
                      selectedValuePop = value!;
                      azalanSirala();
                    });
                  },
                  title: Text("Azalan Fiyat"),
                ),
                RadioListTile<int>(
                  value: 4,
                  groupValue: selectedValuePop,
                  onChanged: (value) {
                    setState(() {
                      selectedValuePop = value!;
                      puanSirala();
                    });
                  },
                  title: Text("Yüksek Puan"),
                ),
              ],
            ),
          );
        });
  }

  void artanSirala() {
    products.sort(((a, b) {
      return a.fiyat.compareTo(b.fiyat);
    }));
    setState(() {});
  }

  void azalanSirala() {
    products.sort(((a, b) {
      return b.fiyat.compareTo(a.fiyat);
    }));
    setState(() {});
  }

  void puanSirala() {
    products.sort(((a, b) {
      return b.puanOrt.compareTo(a.puanOrt);
    }));
    setState(() {});
  }

  void siraYok() {
      
    products = [];
    products.addAll(tempProducts);
    setState(() {});
  }

  GestureDetector FavoriIconu(Urun currentUrun, int index) {
    return GestureDetector(
        onTap: () async {
          setState(() {
            if (favorilenmisUrunler.any((element) => element.isim == currentUrun.isim)) {
              favorilenmisUrunler
                  .remove(currentUrun);
            } else
              favorilenmisUrunler
                  .add(currentUrun);
          });
          await context.read<FavorilerProvider>().clickToUpdateFavorite(currentUrun);
          await context.read<FavorilerProvider>().getFavorites();
          favorilenmisUrunler = [];
          favorilenmisUrunler = await context.read<FavorilerProvider>().getfavoriUrunler;
          setState(() {
            
          });
          favorilenmisUrunler.forEach((e) { print(e.isim); });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Icon(!favorilenmisUrunler.any((e) => e.id == currentUrun.id)
                  ? Icons.favorite_border
                  : Icons.favorite)),
        ));
  }

  Widget siralaFiltreleRowu() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 60,
        child: Card(
          color: Colors.grey.shade200,
          elevation: 10,
          child: Row(
            children: [
              Spacer(),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {},
                      child: shareButonu())), //Paylaşma ekranı açılacak
              Spacer(),
              Expanded(
                  flex: 2,
                  child: GestureDetector(
                      onTap: () {
                        poplama();
                      },
                      child: siralaButonu())),
              Spacer(),
              Expanded(
                  flex: 2,
                  child: GestureDetector(
                      onTap: () {
                        filtre();
                      },
                      child: filtrelemeButonu())),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  Widget filtrelemeButonu() {
    return Row(
      children: [
        Icon(Icons.filter_alt_rounded),
        Text(" Filtrele"),
      ],
    );
  }

  Widget siralaButonu() {
    return Row(
      children: [
        Icon(Icons.compare_arrows_sharp),
        Text(" Sırala"),
      ],
    );
  }

  Widget shareButonu() => Icon(Icons.ios_share);

  filtre() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                Spacer(),
                Divider(
                  color: Colors.grey,
                  indent: MediaQuery.of(context).size.width * 0.35,
                  endIndent: MediaQuery.of(context).size.width * 0.35,
                  thickness: 2,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      markaDialog();
                    },
                    child: Text("Markalar")),
                TextButton(
                    onPressed: () {
                      fiyatDialog();
                    },
                    child: Text("Fiyat Aralığı")),
                Spacer(
                  flex: 3,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (markaSecilenler.isNotEmpty) {
                        filtreList = tempProducts
                            .where((e) => markaSecilenler.contains(e.marka))
                            .toList();
                      } else {
                        filtreList = tempProducts;
                      }
                      products = filtreList
                          .where((e) =>
                              e.fiyat >=
                                  filtreFiyatListesi[secilmisFiyatOpt]["min"] &&
                              e.fiyat <=
                                  filtreFiyatListesi[secilmisFiyatOpt]["max"])
                          .toList();
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Filtreleri Uygula")),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
        }).whenComplete(() => setState(() {}));
  }

  void fiyatDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          secilmisFiyatOpt = 1;
                          setState(() {});
                        },
                        child: Text(
                          "0 - 50 TL arası ",
                          style: TextStyle(
                              color:
                                  secilmisFiyatOpt == 1 ? Colors.green : null),
                        )),
                    secilmisFiyatOpt == 1 ? Icon(Icons.done) : SizedBox.shrink()
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          secilmisFiyatOpt = 2;
                          setState(() {});
                        },
                        child: Text(
                          "50 - 100 TL arası",
                          style: TextStyle(
                              color:
                                  secilmisFiyatOpt == 2 ? Colors.green : null),
                        )),
                    secilmisFiyatOpt == 2 ? Icon(Icons.done) : SizedBox.shrink()
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          secilmisFiyatOpt = 3;
                          setState(() {});
                        },
                        child: Text(
                          "100 - 200 TL arası",
                          style: TextStyle(
                              color:
                                  secilmisFiyatOpt == 3 ? Colors.green : null),
                        )),
                    secilmisFiyatOpt == 3 ? Icon(Icons.done) : SizedBox.shrink()
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          secilmisFiyatOpt = 4;
                          setState(() {});
                        },
                        child: Text(
                          "200 TL üzeri",
                          style: TextStyle(
                              color:
                                  secilmisFiyatOpt == 4 ? Colors.green : null),
                        )),
                    secilmisFiyatOpt == 4 ? Icon(Icons.done) : SizedBox.shrink()
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      secilmisFiyatOpt = 0;
                      setState(() {});
                    },
                    child: Text("Filtreyi kaldır")),
              ],
            ),
          );
        });
  }

  void markaDialog() {
    List<String> markalar = tempProducts.map((e) => e.marka).toSet().toList();
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            children: [
              AlertDialog(
                  content: Column(children: [
                StatefulBuilder(
                  builder: (context, setState) => Column(
                      children: markalar
                          .map((e) => CheckboxListTile(
                              title: Text(e),
                              value: markaSecilenler.contains(e),
                              onChanged: (value) {
                                !markaSecilenler.contains(e)
                                    ? markaSecilenler.add(e)
                                    : markaSecilenler.remove(e);
                                setState(
                                  () {},
                                );
                              }))
                          .toList()),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Seçimleri tamamla"))
              ])),
            ],
          );
        });
  }
}
