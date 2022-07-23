import 'package:flutter/material.dart';
import '../../app_constants/app_strings.dart';
import '../../providers/favoriler_provider.dart';
import 'urun_ekrani_view.dart';
import '../../widgets/add_basket_button.dart';
import '../../widgets/page_appbar_title.dart';
import '../../widgets/product_container.dart';
import '../../widgets/product_label_headline6.dart';
import 'package:provider/provider.dart';
import '../../models/urun.dart';
import '../../utilities/route_helper.dart';

class Favoriler extends StatefulWidget {
  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: PageAppBarTitle(text: "$favorilerimAppTitle")),
      body: _bodyView(context),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      //todo Burada favori listesindeki ürünleri getirecek şekilde ayarlama yapıcaz. Ayrıca Bir de favori ürünü listeden çıkarmak için buton yapmak lazım.
      child: product_gridView(context)
    );
  }

  GridView product_gridView(BuildContext context) {
    return GridView.builder(
      itemCount: context.watch<FavorilerProvider>().getfavoriUrunler.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return productColumn(context, context.watch<FavorilerProvider>().getfavoriUrunler, index);
      },
    );
  }

  Column productColumn(BuildContext context, List<Urun> favoriListesi, int index) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ProductContainer(
                onTap: () => RouteHelper.goRoute(context: context, page: urunEkrani(favoriListesi[index])),
                imageUrl: favoriListesi[index].urunResimleriUrl[0]
              ),
              favoriteButton(favoriListesi[index])
            ]
          ),
        ),
        ProductLabelHeadline6(text: favoriListesi[index].fiyat.toString()),
        ProductLabelHeadline6(text: favoriListesi[index].isim),
        AddBasketButton(urun: favoriListesi[index]),
      ],
    );
  }

  Positioned favoriteButton(Urun urun) {
    return Positioned(
      right: 5,
      child: IconButton(
        //todo Burada kalp icon buttonına basıldığında sayfa yenilenecek ve o ürün kaldırılacak. Aynı zamanda müşterinin favori listesi de güncellenerek bahse konu ürün oradaki databaseden de silinerek güncellenecek.
        onPressed: () async {
          await context.read<FavorilerProvider>().clickToUpdateFavorite(urun);
          await context.read<FavorilerProvider>().getFavorites();
        },
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
          size: 30,
        ),
      ),
    );
  }
}


