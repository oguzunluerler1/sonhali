import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/models/urun.dart';
import 'package:idea_ecommerce_app/services/database.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';

class ProductsInCat extends StatefulWidget {
  const ProductsInCat({Key? key, required this.title, required this.categoryId}) : super(key: key);
  final String title;
  final String categoryId;
  @override
  State<ProductsInCat> createState() => _ProductsInCatState();
}

class _ProductsInCatState extends State<ProductsInCat> {

  List<String> urlList = [
    "https://www.pngmart.com/files/3/Music-PNG-Photos.png",
    "https://assets.stickpng.com/thumbs/580b57fcd9996e24bc43c543.png",
    "https://assets.stickpng.com/images/580b57fcd9996e24bc43c53e.png",
    "https://assets.stickpng.com/images/580b57fcd9996e24bc43c4cf.png",
    "https://assets.stickpng.com/images/580b585b2edbce24c47b2cf2.png",
    "https://assets.stickpng.com/images/580b57fcd9996e24bc43c548.png",
  ];

  List<Urun> products = [];

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
    products = docSnap.where((element) => element.kategoriId == widget.categoryId).toList();
    products.forEach((element) {print(element.isim);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        title: PageAppBarTitle(text: widget.title),
      ),
      body: bodyMethod(),
    );
  }

  Widget bodyMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){ },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
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
                Text("Kategori $index")
              ],
            ),
          );
        },
      ),
    );
  }

  Image image(int index) => Image.network("${urlList[index]}", fit: BoxFit.contain);
}