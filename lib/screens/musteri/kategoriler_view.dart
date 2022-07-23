import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/app_constants/app_strings.dart';
import 'package:idea_ecommerce_app/providers/category_provider.dart';
import 'package:idea_ecommerce_app/screens/musteri/kategoriSecilen.dart';
import 'package:idea_ecommerce_app/utilities/route_helper.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';
import 'package:provider/provider.dart';

class KategorilerView extends StatefulWidget {
  const KategorilerView({Key? key}) : super(key: key);


  @override
  State<KategorilerView> createState() => _KategorilerViewState();
}

class _KategorilerViewState extends State<KategorilerView> {

  List<String> urlList = [
    "https://www.pngall.com/wp-content/uploads/4/White-Cup-PNG.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: PageAppBarTitle(text: kategorilerAppTitle),
      ),
      body: bodyMethod(),
    );
  }

  Widget bodyMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: context.watch<CategoryProvider>().getCategories.length,
        itemBuilder: (BuildContext context, int index) {
          String category = context.read<CategoryProvider>().getCategories[index];
          String categoryId = context.read<CategoryProvider>().getCategoryDetailMap[index]["id"];
          
          return GestureDetector(
            onTap: (){
              //RouteHelper.goRoute(context: context, page: ProductsInCat(title: "${category}",categoryId: categoryId,));
              RouteHelper.goRoute(context: context, page: secilmisKategoriScreen(title: "${category}",categoryId: categoryId,));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded( flex: 4,
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
                SizedBox(height: 6,),
                Expanded(child: Text("${context.read<CategoryProvider>().getCategories[index]}",textAlign: TextAlign.center,))
              ],
            ),
          );
        },
      ),
    );
  }

  Image image(int index) {
    return Image.network(
      "${context.read<CategoryProvider>().getCategoryDetailMap[index]["resimurl"]}", 
      fit: BoxFit.contain
    );
  }
}