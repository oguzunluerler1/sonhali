import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/urun.dart';
import '../../providers/urun_ozellikleri_provider.dart';

class UrunOzellikleri extends StatefulWidget {
   UrunOzellikleri(this.urun, {Key? key}) : super(key: key);

  @override
  State<UrunOzellikleri> createState() => _UrunOzellikleriState();

  final Urun urun;
}

class _UrunOzellikleriState extends State<UrunOzellikleri> {
  @override
  Widget build(BuildContext context) {
   return FutureBuilder<String>(
      future: Provider.of<UrunOzellikleriProvider>(context, listen: false)
          .urunOzellikleri(widget.urun),
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
