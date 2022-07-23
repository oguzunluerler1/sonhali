//todo YAPILACAK SAYFALAR
/*KullaniciAnaSayfaView -->     Emre +
KullaniciFavorilerView -->    Emre   +
AramaView -->            Emre
SatinAlmaView -->        Emre         +
YorumlarimView -->        Emre ---------------------yorum yapma view yapmamız lazım +++
SigninView yaptım ama hesap oluştur yok daha .
*/

//*Firebase kullanmak için en başta yüklemek zorunda olduğumuz, firebase'i initilize edebilmemize yarayan paket.

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//*Flutter'ın en çok kullandığı standart material kütüphanesi. Flutterla otomatik yüklü geliyor. Sadece import ediyoruz.
import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/app_constants/app_strings.dart';
import 'package:idea_ecommerce_app/providers/adreslerim_provider.dart';
import 'package:idea_ecommerce_app/providers/basket_provider.dart';
import 'package:idea_ecommerce_app/providers/category_provider.dart';
import 'package:idea_ecommerce_app/providers/urun_ozellikleri_provider.dart';
import 'package:idea_ecommerce_app/providers/yeni_adres_olustur_provider.dart';
import 'package:idea_ecommerce_app/screens/musteri/arama_view_model.dart';
import 'package:idea_ecommerce_app/providers/favoriler_provider.dart';
import 'package:idea_ecommerce_app/screens/musteri/kullanicisepet_View_Model.dart';

import 'package:idea_ecommerce_app/services/auth.dart';
import 'package:idea_ecommerce_app/widgets/on_board.dart';
import './screens/musteri/anaSayfa_view_model.dart';
import 'package:idea_ecommerce_app/services/database.dart';
import 'package:provider/provider.dart';

//*Firebase'i initialize ederken options kısmındaki komutu kullanmamızı sağlayan dosya. Firebase CLI sayesinde kuruyoruz. İşlem biraz uzun FlutterFire sitesinde ayrıntılı dökümanı var. Bu şekilde her platform için Firebase ayarlarını otomatik yapıyor.
import 'firebase_options.dart';
import 'providers/favoriler_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//*Firebase'in initialize edilmesi asenkron bir işlem olduğu için main fonksiyonunu async yapıyoruz. İnitialize yaparken de await ifadesi ile sistemi bekletiyoruz.
void main() async {
    HttpOverrides.global = new MyHttpOverrides();
//*Buradaki komut daha program kurulmadan bir işlem yapılacaksa bunu bildirmek için yazılıyor. Eğer bu komutu yazmazsak program hata veriyor.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true,);
//*Widget ağacının en başına multiprovider ekledim bunun üzerinden istediğimiz şekilde state management ayarlamalarını yapabileceğiz.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => FavorilerProvider()),
      ChangeNotifierProvider(create: (context) => BasketProvider()),
      Provider<Database>(create: (context) => Database()),
      Provider<UrunOzellikleriProvider>(
          create: (context) => UrunOzellikleriProvider()),
      Provider<AdreslerimProvider>(create: (context) => AdreslerimProvider()),
      Provider<YeniAdresOlusturProvider>(
          create: (context) => YeniAdresOlusturProvider()),
      Provider<KullaniciSepetViewModel>(
          create: (context) => KullaniciSepetViewModel()),
      Provider<Auth>(create: (context) => Auth()),
      ChangeNotifierProvider<AnasayfaViewModel>(
          create: ((context) => AnasayfaViewModel())),
      Provider<AramaViewModel>(create: (context) => AramaViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$mainAppName',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onSurface: Colors.black,
                onPrimary: Colors.black,
                textStyle: TextStyle(color: Colors.black))),
        textTheme: TextTheme(headline6: TextStyle(fontWeight: FontWeight.bold)),
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()),
        appBarTheme:
            AppBarTheme(centerTitle: true, color: Colors.white, elevation: 3),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.black.withOpacity(0.6)),
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
      ),
      home: OnBoardWidget(),
    );
  }
}
