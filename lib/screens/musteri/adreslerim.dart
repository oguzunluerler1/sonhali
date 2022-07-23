import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/adreslerim_provider.dart';
import 'package:idea_ecommerce_app/screens/musteri/yeni_adres_olustur.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';
import 'package:provider/provider.dart';

import '../../models/adres.dart';
import '../../widgets/loading_indicator.dart';

class adreslerim extends StatefulWidget {
  const adreslerim({Key? key}) : super(key: key);

  @override
  State<adreslerim> createState() => _adreslerimState();
}

class _adreslerimState extends State<adreslerim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        title: PageAppBarTitle(text: 'Adreslerim'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'YENİ ADRES OLUŞTUR',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w800,color: Colors.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YeniAdresOlustur(),
                                ));
                            print('yeni adres oluştur sayfasına gidecek');
                          },
                          child: Icon(Icons.add_circle_outline)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    productFutureBuilder(
                        context: context,
                        future:
                            context.watch<AdreslerimProvider>().adresBilgisi()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

FutureBuilder<List<Adres>> productFutureBuilder(
    {required BuildContext context, Future<List<Adres>>? future}) {
  return FutureBuilder<List<Adres>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return ListView.builder(
            itemCount: snapshot.data?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var adres = snapshot.data?[index];
              var subtitle =
                  '${adres?.mahalle} mahallesi ${adres?.cadde} caddesi ${adres?.sokak} sokağı ${adres?.apartman} apartmanı ${adres?.katBlok} ${adres?.daireNo} ${adres?.ilce} ${adres?.il} ';

              return Card(
                child: ListTile(
                  title: Text(
                    adres!.adresIsmi,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.purple),
                  ),
                  subtitle: Text(subtitle),
                ),
              );
            },
          );
        else
          return LoadingIndicator();
      });
}
