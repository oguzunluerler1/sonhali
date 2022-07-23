import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ekrani_view.dart';
import 'package:idea_ecommerce_app/utilities/route_helper.dart';

import '../../app_constants/app_strings.dart';
import '../../models/urun.dart';
import '../../services/database.dart';

class Arama extends StatefulWidget {
  const Arama({Key? key}) : super(key: key);

  @override
  State<Arama> createState() => _AramaState();
}

TextEditingController tfArama = TextEditingController();

class _AramaState extends State<Arama> {


    List<Urun> products = [];
    List<Urun> productsSearch = [];

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
    products = data.docs.map((e) => Urun.fromMap(e.data())).toList();
    productsSearch = products;
    setState(() {
      
    });
    //products = docSnap.where((element) => element.kategoriId == widget.categoryId).toList();
  }

  void buildSearch(String query){
    print(query);
    if (query.isNotEmpty) {
      productsSearch = products.where((element) => element.isim.toLowerCase().contains(query.toLowerCase())).toList();
    }else{
      productsSearch = products;
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'Ürün Arama',
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (String value) {
                buildSearch(value);
              },
              controller: tfArama,
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: searchHintText),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: grid()),
          ],
        ),
      ),
    );
  }

  Padding grid() {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1/2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: productsSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            RouteHelper.goRoute(context: context, page: urunEkrani(productsSearch[index]));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.primaries[index % Colors.primaries.length].shade200,
                    child: image(index)
                  )
                ),
              ),
              SizedBox(height: 8,),
              Expanded(child: Text(productsSearch[index].isim,textAlign: TextAlign.center,))
            ],
          ),
        );
      },
    ),
  );
  }

  Image image(int index) => Image.network("${productsSearch[index].urunResimleriUrl[0]}", fit: BoxFit.contain);

}
