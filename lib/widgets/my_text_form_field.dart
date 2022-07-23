import 'package:flutter/material.dart';

class myTextFormField extends StatelessWidget {
  const myTextFormField(
      {Key? key,
      required TextEditingController adresIsmiController,
      required String hintText,
      int lines = 1})
      : _adresIsmiController = adresIsmiController,
        _hintText = hintText,
        _lines = lines,
        super(key: key);
  final int _lines;
  final String _hintText;
  final TextEditingController _adresIsmiController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: _lines,
      controller: _adresIsmiController,
      validator: (value) {
//*Burada emailvalidator paketi ile kontrol yapıyoruz. Girilen değer null değilse ve email formatına uyuyorsa okey veriyor yoksa hata döndürüyor.
        if (value!.isEmpty) {
          return 'Boş bırakılamaz.';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: TextStyle(color: Colors.purple.shade200),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple.shade200, width: 2)),
      ),
    );
  }
}
