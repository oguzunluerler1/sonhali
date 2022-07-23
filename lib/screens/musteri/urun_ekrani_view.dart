import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ozellikleri.dart';
import '../../providers/favoriler_provider.dart';
import '../../widgets/add_basket_button.dart';
import 'package:provider/provider.dart';

import '../../models/urun.dart';

class urunEkrani extends StatefulWidget {
  urunEkrani(this.urun, {Key? key}) : super(key: key);
  final Urun urun;

  @override
  State<urunEkrani> createState() => _urunEkraniState();
}

class _urunEkraniState extends State<urunEkrani> {
  bool inList = false;

  @override
  Widget build(BuildContext context) {
    inList =
        context.read<FavorilerProvider>().getProductInListValue(widget.urun);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.urun.isim}'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: _bodyView(context),
    );
  }

  SingleChildScrollView _bodyView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image(image: NetworkImage(widget.urun.urunResimleriUrl[0])),
          ListTile(
            title: Text(
              widget.urun.marka,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.purple),
            ),
            subtitle: Text(widget.urun.isim),
          ),
          ratingTile(),
          Row(
            children: [
              saticiText(),
              Spacer(),
              eTicaretTextButton(),
            ],
          ),
          askSellerButton(),
          productDetails(),
          rowBtnFavoriteProductAmount(context),
        ],
      ),
    );
  }

  Row ratingTile() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            widget.urun.puanOrt.toString(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.star, size: 14, color: Colors.yellow[400]),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 130.0),
          child: GestureDetector(
              onTap: () {
                print('değerlendirme sayfasına girecek');
              },
              child: Text(
                'Tüm Değerlendirmeler(${widget.urun.degsayisi})',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.purple),
              )),
        ),
      ],
    );
  }

  Padding saticiText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        "Satıcı",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

  Padding eTicaretTextButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
          onTap: () {
            //todo: satıcı ekranına gönderilecek
          },
          child: Text(
            widget.urun.satici,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.purple[800]),
          )),
    );
  }

  ElevatedButton askSellerButton() {
    return ElevatedButton(
      onPressed: () {
        //todo: satıcıya soru sorma ekranına yönlendirielcek
      },
      child: Text('Satıcıya sor'),
      style: ElevatedButton.styleFrom(primary: Colors.purple[400]),
    );
  }

  Column productDetails() {
    return Column(
      children: [
        productDetailTile(
            text: "Ürün Açıklamaları",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UrunOzellikleriView(urun: widget.urun),
                  ));
              //RouteHelper.goRoute(context: context, page: adreslerim());
            }),
        productDetailTile(text: "Ürün Özellikleri", onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UrunOzellikleriView(urun: widget.urun),
                  ));
            }),
        //productDetailTile(text: "Kampanyalar", onTap: () {}),
        //productDetailTile(text: "Soru&Cevap", onTap: () {}),
        productDetailTile(text: "İptal Ve iade Koşulları", onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UrunOzellikleriView(urun: widget.urun),
                  ));
            }),
      ],
    );
  }

  Row productDetailTile({required String text, required VoidCallback onTap}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$text',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
        ),
        Spacer(),
        InkWell(onTap: onTap, child: Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }

  Row rowBtnFavoriteProductAmount(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text('${widget.urun.fiyat} TL'),
        ),
        Spacer(),
        favoriteIconButton(context),
        AddBasketButton(
          urun: widget.urun,
        )
      ],
    );
  }

  InkWell favoriteIconButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context
            .read<FavorilerProvider>()
            .clickToUpdateFavorite(widget.urun);
        await context.read<FavorilerProvider>().getFavorites();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: inList ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      ),
    );
  }
}
