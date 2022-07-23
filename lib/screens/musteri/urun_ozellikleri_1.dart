import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/urun_ozellikleri_provider.dart';
import 'package:provider/provider.dart';

import '../../models/urun.dart';

class UrunAciklamalari extends StatefulWidget {
  UrunAciklamalari(this.urun, {Key? key}) : super(key: key);

  @override
  State<UrunAciklamalari> createState() => _UrunAciklamalariState();

  final Urun urun;
}

class _UrunAciklamalariState extends State<UrunAciklamalari> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Provider.of<UrunOzellikleriProvider>(context, listen: false)
          .urunAciklamalari(widget.urun),
      initialData: '',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(snapshot.data ?? ''),
        );
      },
    );
  }
}
