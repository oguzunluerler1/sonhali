import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class kartEklemeView extends StatefulWidget {
  const kartEklemeView({Key? key}) : super(key: key);

  @override
  State<kartEklemeView> createState() => _kartEklemeViewState();
}

class _kartEklemeViewState extends State<kartEklemeView> {
  var CreditCardNr;
  var CreditCardName;
  var CreditCardExpnDate;
  var CVV;
  TextEditingController CCNumberController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController ExpnDateController = TextEditingController();
  TextEditingController CVVController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Yeni kart ekleme", style: TextStyle(color: Colors.purple),),
          centerTitle: true,
          actions: [
            GestureDetector(child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.person,color: Colors.purple,),
            ), onTap: (){print("Profil ekranına dönüş yap");},)
          ],
        ),
        body: bodyMethod(),
      ),
    );
  }

  Widget bodyMethod() {
    return SingleChildScrollView(
      child: Column(
        children: [
          KartNumarasi(),
          KartUzeriIsim(),
          KartSTTveCVV(),
          ElevatedButton(onPressed: (){
            setState(() {
              CreditCardNr = CCNumberController.text;
              CreditCardName = NameController.text;
              CreditCardExpnDate = ExpnDateController.text;
              CVV = CVVController.text;

              print("$CreditCardNr , $CreditCardName , $CreditCardExpnDate , $CVV");
            });
          }, child: Text("Kart ekle"))
        ],
      ),
    );
  }

  Widget KartNumarasi() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 140,
            child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Kart numarası"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: CCNumberController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberFormatter(),
                      ],
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "**** **** **** ****"
                      ),
                      maxLength: 19,
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }


  Widget KartUzeriIsim() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 120,
            child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Kart üzerindeki isim"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: NameController,
                      decoration: InputDecoration(
                        hintText: "Kart sahibinin adı ve soyadı"
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }

  Widget KartSTTveCVV() {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 120,
              width: MediaQuery.of(context).size.width * 0.45,
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Son kullanma tarihi"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: ExpnDateController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                          CreditCardExpirationDateFormatter(),
                          ],
                          decoration: InputDecoration(
                            hintText: "Ay/Yıl"
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),
                  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 120,
              width: MediaQuery.of(context).size.width * 0.45,
                child:Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Güvenlik kodu"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: CVVController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CreditCardCvcInputFormatter()
                          ],
                          decoration: InputDecoration(
                            hintText: "CVC/CVV"
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),
      ],
    );
  }
}


class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}