//todo Son gezilen ürünler tamam. Diğer ikisi genel ürünleri çekiyor üzerlerinde oynama yapabilirim.
//todo SepeteEkle tuşunu aktive etmem lazım.
//todo Reklam panosunu halletmem lazım.
import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/app_constants/app_strings.dart';
import 'package:idea_ecommerce_app/models/urun.dart';
import 'package:idea_ecommerce_app/screens/musteri/arama_view.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ekrani_view.dart';
import 'package:idea_ecommerce_app/screens/sign_in.dart';
import 'package:idea_ecommerce_app/services/auth.dart';
import 'package:idea_ecommerce_app/widgets/add_basket_button.dart';
import 'package:idea_ecommerce_app/widgets/loading_indicator.dart';
import 'package:idea_ecommerce_app/widgets/product_container.dart';
import 'package:idea_ecommerce_app/widgets/product_label_headline6.dart';
import '../../utilities/route_helper.dart';
import '../../widgets/page_appbar_title.dart';
import 'anaSayfa_view_model.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: PageAppBarTitle(text: homePageAppTitle),
        actions: [ logOutButton(context), ],

      ),
      body: _bodyView(context),
    );
  }


  IconButton logOutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Provider.of<Auth>(context, listen: false).signOut();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ));
      },
      icon: Icon(Icons.logout, color: Colors.black.withOpacity(0.6)),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            searchTextField(context),
            SizedBox(height: 10),
            reklamPanosu(context: context, imageUrl: "$reklamPanoImageUrl"),
            SizedBox(height: 20),
            sectionTitle(text: populerUrunlerText),
            SizedBox(height: 10),
            //todo Buradaki futurebuilder şu an için databasedeki bütün ürünlerin bilgisini çekiyor. Normalde popüler ürünleri bir şekilde belirleyip onları çekmesi lazım. Alt taraftakilerde de son gezilen ürünler veya sizin için seçtiklerimiz tarzı listelerden seçmesi lazım.
            //*Providerın farklı bir kullanım formatını kullandık aşağıda.
            productFutureBuilder(
                context: context,
                future:
                    context.watch<AnasayfaViewModel>().tumUrunVerisiOkuma()),
            sectionTitle(text: sonGezilenUrunlerText),
            SizedBox(height: 10),
            productFutureBuilder(
                context: context,
                future: Provider.of<AnasayfaViewModel>(context)
                    .tiklananUrunVerisiOkuma()),
            sectionTitle(text: sizinIcinSectikText),
            SizedBox(height: 10),
            productFutureBuilder(
                context: context,
                future: Provider.of<AnasayfaViewModel>(context)
                    .tumUrunVerisiOkuma()),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  TextField searchTextField(BuildContext context) {
    return TextField(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Arama())));
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: searchHintText,
      ),
    );
  }
      
  Widget reklamPanosu(
      {required BuildContext context, required String imageUrl}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          //todo Burada reklam panosuna geçici bir resim ekledim url koyarak. Normalde adminler tarafından belirlenen kampanyaların resimlerini koyucaz ve gesturededector ile farklı resimlere geçmelerini veya tıklayarak ilgili kampanya ürünlerini görmelerini sağlayacağız.
          image: DecorationImage(
              image: NetworkImage('$imageUrl'), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black54),
        ),
      ),
    );
  }

  Text sectionTitle({required String text}) {
    return Text(
      "$text",
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Color.fromARGB(255, 40, 2, 104), fontWeight: FontWeight.bold),
    );
  }

  FutureBuilder<List<Urun>> productFutureBuilder(
      {required BuildContext context, Future<List<Urun>>? future}) {
    return FutureBuilder<List<Urun>>(

      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) return productGridView(context, snapshot);
        else return LoadingIndicator();
      }
    );

  }

  SizedBox productGridView(
      BuildContext context, AsyncSnapshot<List<Urun>> snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: GridView.builder(
        itemCount: snapshot.data?.length ?? 0,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return productColumn(context, snapshot, index);
        },
      ),
    );
  }

  Column productColumn(
      BuildContext context, AsyncSnapshot<List<Urun>> snapshot, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        ProductContainer(
          onTap: () => RouteHelper.goRoute(context: context, page: urunEkrani(snapshot.data![index])), 
          imageUrl: snapshot.data?[index].urunResimleriUrl[0]
        ),
        ProductLabelHeadline6(text: "${snapshot.data?[index].fiyat.toString()} TL"),
        Text(snapshot.data?[index].isim ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Expanded(child: AddBasketButton(urun: snapshot.data![index],)),
      ],
    );
  }

}

