import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/category_provider.dart';
import '../../app_constants/app_strings.dart';
import '../../providers/basket_provider.dart';
import '../../providers/favoriler_provider.dart';
import 'kullanicisepet.dart';
import 'kullanicisepet_View_Model.dart';
import '../../widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../models/urun.dart';
import 'anaSayfa_view.dart';
import 'favoriler_view.dart';
import 'hesap_view.dart';
import 'kategoriler_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
//*index değişkeni tanımladım ve varsayılan olarak 0 belirledim. Böylece ilk ekran açıldığında anasayfa geliyor. Bu index değişimine göre sayfa geçişleri yapılacak.
  int index = 0;
  List<Widget> pages = [
    AnaSayfa(),
    Favoriler(),
    KullaniciSepetView(),
    KategorilerView(),
    KullaniciHesabiView(),
  ];
  int basketCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavorilerProvider>().getFavorites();
      context.read<BasketProvider>().getBasket();
      context.read<CategoryProvider>().getAllCategories();
    });
  }

  void goToSelectedPage(int num){
    index = num;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//*index durumuna göre body olarak kullanılacak sayfayı belirleyen kod
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (secilenIndex) => setState(() => index = secilenIndex),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
//*Burada bottomnavigationbar da bulunacak tuşları ayarlıyoruz. items içine sırasıyla istediğimiz icon ve metinleri yazıyoruz. Aynı zamanda bu items içindeki elemanların indexi onTap deki secilenIndex oluyor ve ona göre ekran yeniden çiziliyor.
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "$navBarAnaSayfaText"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "$navBarFavorilerimText"),
            BottomNavigationBarItem(
                icon:
                    Stack(children: [Icon(Icons.shopping_cart), basketBadge()]),
                label: "$navBarSepetimText"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "$navBarKategorilerText"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: "$navBarHesabimText"),

          ],
        ),
      ),
    );
  }

  Positioned basketBadge() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: 12,
        height: 12,
        child: Center(

          child:FutureBuilder<List<Urun>?>(
            future: Provider.of<KullaniciSepetViewModel>(context).sepetUrunVerisiOkuma(),

            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "${context.watch<BasketProvider>().amount.fold<int>(0, (previousValue, element) => previousValue + element)}",
                  style: TextStyle(color: Colors.white,fontSize: 10),
                );
              } else {
                return LoadingIndicator();

              }
            },
          ),
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Color.fromARGB(255, 255, 0, 0)),
      ),
    );
  }
}
