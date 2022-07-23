import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ozellikleri_1.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ozellikleri_2.dart';
import 'package:idea_ecommerce_app/screens/musteri/urun_ozellikleri_3.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';

import '../../models/urun.dart';

class UrunOzellikleriView extends StatefulWidget {
  UrunOzellikleriView({Key? key, required this.urun}) : super(key: key);

  @override
  State<UrunOzellikleriView> createState() => _UrunOzellikleriViewState();

  final Urun urun;
}

class _UrunOzellikleriViewState extends State<UrunOzellikleriView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.deepPurple,
            title: PageAppBarTitle(text: 'Ürün Özellikleri'),
            bottom: TabBar(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: 'Ürün \nAçıklamaları',
                ),
                Tab(text: 'Ürün \nÖzellikleri'),
                Tab(
                  text: 'İptal ve İade \nKoşulları',
                )
              ],
              indicatorColor: Colors.purple,
              labelColor: Colors.purpleAccent,
            ),
          ),
          body: TabBarView(children: [
            UrunAciklamalari(widget.urun),
            UrunOzellikleri(widget.urun),
            IptalVeIadeKosullari()
          ]),
        ));
  }
}
