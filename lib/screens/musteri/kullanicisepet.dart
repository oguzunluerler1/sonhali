import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/basket_provider.dart';
import 'package:idea_ecommerce_app/services/calculator.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../app_constants/app_strings.dart';
import '../../models/urun.dart';

class KullaniciSepetView extends StatefulWidget {
  const KullaniciSepetView({Key? key}) : super(key: key);
  @override
  State<KullaniciSepetView> createState() => _KullaniciSepetViewState();
}

class _KullaniciSepetViewState extends State<KullaniciSepetView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox.shrink(),
          title: PageAppBarTitle(text: "Sepetim")
        ),
        body: _bodyView(context),
      ),
    );
  }


  Widget _bodyView(BuildContext context) {
    var sepet = context.watch<BasketProvider>().sepet;
    return Column(
      children: [
        saticiKargoListTile(),
        alisverisTamamla(context, sepet),
        sepet.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                itemCount: sepet.length,//snapshot.data?.length,
                itemBuilder: (context, index) {
                  return basketProduct(sepet[index], index,context);
                },
              ),
            )
          : Expanded(
              child: Center(  
                child: Column(
                  children: [
                    Expanded(flex: 4,child: Lottie.network("https://assets4.lottiefiles.com/packages/lf20_iszpuyas.json",fit: BoxFit.fitHeight)),
                    Expanded(child: Text("Sepetiniz boş! Alışveriş yapmak için ürün ekleyiniz.",style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
              )
            )
      ],
    );
  }

  Container saticiKargoListTile() {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      height: MediaQuery.of(context).size.height*0.09,
      width: double.infinity,
      child: ListTile(
        title: cargoPriceStatus(),
        
      ),
    );
  }

  Row cargoPriceStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.local_shipping, color: Colors.purple),
            Text(" Kargo Bedava",
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            )
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(onPrimary: Colors.white, primary: Colors.purple),
          onPressed: () async {
            await context.read<BasketProvider>().sepetiBosalt();
            await context.read<BasketProvider>().getBasket();
          }, child: Text("Sepeti Boşalt"))
      ],
    );
  }

  Widget alisverisTamamla(BuildContext context, List<Urun> listSepet) {
    int toplamFiyat = 0;
    List<int> amounts = context.read<BasketProvider>().amount;
    int toplamUrunCount = amounts.fold<int>(0, (previousValue, element) => previousValue + element);
    for (var i = 0; i < listSepet.length; i++) {
      toplamFiyat += listSepet[i].fiyat * amounts[i];
    }
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1), top: BorderSide(width: 0.5))),
      height: MediaQuery.of(context).size.height*0.14,
      width: double.infinity,
      child: ListTile(
        title: toplamUrun(toplamFiyat,toplamUrunCount),
        trailing: checkOutBtn(toplamFiyat),
      ),
    );
  }

  Column checkOutBtn(int toplamFiyat) {
    return Column(
      children: [
        Expanded(
          child: Text("$toplamFiyat TL",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(onPrimary: Colors.white, primary: Colors.purple),
            onPressed: () {},
            child: Text('Ödemeyi Tamamla')),
        ),
      ],
    );
  }

  Column toplamUrun(int toplamFiyat,int itemCount) {
    return Column(
        children: [
          Spacer(),
          Text("Seçilen Ürünler ($itemCount)"),
          Text("$toplamFiyat TL",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Kargo bedeli = 0 TL"),
          Spacer(),
        ],
      );
  }

  Widget basketProduct(Urun urun, int index,BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: double.infinity,
        child: ListTile(
          leading: productImage(urun.urunResimleriUrl[0]),
          title: productDetail(urun.isim, urun.fiyat, urun.satici, index, context),
          trailing: eklecikar(index,urun),
        ),
      ),
    );
  }

  Column productDetail(String pName, int pPrice, String saticiName, int index, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pName,
          style: TextStyle(fontWeight:FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(getTeslimTarihi(Calculator.dateTimeToString(DateTime.now().add(Duration(days: Random().nextInt(3))))),
          style:TextStyle(fontSize: 12)),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Satıcı: $saticiName", style: TextStyle(fontSize: 11),),
            Text("${pPrice*context.watch<BasketProvider>().amount[index]} TL"),
          ], 
        )
      ],
    );
  }



  Column productImage(String url) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.16,
            child: Image(
              image: NetworkImage("$url"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Column eklecikar(int index, Urun urun) {
    bool isLoading = false;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ekleCikarButon(Icons.add, () async {
          isLoading = true;
          await context.read<BasketProvider>().addItemToBasket(urun);
          await context.read<BasketProvider>().getBasket();
          isLoading = false;
        }),
        Spacer(),
        Expanded(child: isLoading ? CircularProgressIndicator() : Text("${context.watch<BasketProvider>().amount[index]}")),
        ekleCikarButon(Icons.remove, () async {
          isLoading = true;
          await context.read<BasketProvider>().removeItemToBasket(urun);
          await context.read<BasketProvider>().getBasket();
          isLoading = false;
        })
      ],
    );
  }

  Expanded ekleCikarButon(IconData,VoidCallback onTap) {
    return Expanded(
        child: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: EdgeInsets.zero,
          onPressed: onTap, 
          icon: Icon(IconData)
          ),
      );
  }

}
