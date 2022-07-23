import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/providers/yeni_adres_olustur_provider.dart';
import 'package:idea_ecommerce_app/widgets/page_appbar_title.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_text_form_field.dart';

class YeniAdresOlustur extends StatefulWidget {
  const YeniAdresOlustur({Key? key}) : super(key: key);

  @override
  State<YeniAdresOlustur> createState() => _YeniAdresOlusturState();
}

class _YeniAdresOlusturState extends State<YeniAdresOlustur> {
//*build fonksiyonu içinde tanımlayınca klavye açılıp hemen kapanıyordu ve textler kendi kendine siliniyordu. State içine alınca düzeldi.
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  TextEditingController _adresIsmiController = TextEditingController();
  TextEditingController _caddeController = TextEditingController();
  TextEditingController _apartmanController = TextEditingController();
  TextEditingController _daireNoController = TextEditingController();
  TextEditingController _duzMetinController = TextEditingController();
  TextEditingController _ilController = TextEditingController();
  TextEditingController _ilceController = TextEditingController();
  TextEditingController _katBlokController = TextEditingController();
  TextEditingController _mahalleController = TextEditingController();
  TextEditingController _sokakController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //*Alttaki Form içindeki girilen değerlerin kontrolü için bir tane key tanımlıyoruz.

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: PageAppBarTitle(text: 'Adres Ekleme'),foregroundColor: Colors.deepPurple,),
//*Klavye ekranı yukarı ittiriyordu. Onun için koydum.
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    //*Yukarıda tanımladığımız anahtarı Form widgetının key propertisine atıyoruz.
                    key: _signInFormKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          myTextFormField(
                            adresIsmiController: _adresIsmiController,
                            hintText: 'Adres ismi',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          myTextFormField(
                            adresIsmiController: _mahalleController,
                            hintText: 'Mahalle',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          myTextFormField(
                            adresIsmiController: _caddeController,
                            hintText: 'Cadde',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          myTextFormField(
                            adresIsmiController: _sokakController,
                            hintText: 'Sokak',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          myTextFormField(
                            adresIsmiController: _apartmanController,
                            hintText: 'Apartman',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: myTextFormField(
                                  adresIsmiController: _daireNoController,
                                  hintText: 'Daire',
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: myTextFormField(
                                  adresIsmiController: _katBlokController,
                                  hintText: 'Kat Blok',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: myTextFormField(
                                  adresIsmiController: _ilceController,
                                  hintText: 'İlçe',
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: myTextFormField(
                                  adresIsmiController: _ilController,
                                  hintText: 'İl',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          myTextFormField(
                            lines: 3,
                            adresIsmiController: _duzMetinController,
                            hintText: 'Tarif/Açıklama',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.4,
                                    40)),
                            onPressed: () async {
                              if (_signInFormKey.currentState!.validate()) {
                                context
                                    .read<YeniAdresOlusturProvider>()
                                    .musteriyeAdresEkleme(
                                        adresIsmi: _adresIsmiController.text,
                                        apartman: _apartmanController.text,
                                        cadde: _caddeController.text,
                                        daireNo: _daireNoController.text,
                                        duzMetin: _duzMetinController.text,
                                        il: _ilController.text,
                                        ilce: _ilceController.text,
                                        katBlok: _katBlokController.text,
                                        mahalle: _mahalleController.text,
                                        sokak: _sokakController.text);
                              }
                            },
                            child: Text(
                              'Oluştur',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
