import 'package:flutter/material.dart';

class sikayetEkrani extends StatefulWidget {
  const sikayetEkrani({Key? key}) : super(key: key);

  @override
  State<sikayetEkrani> createState() => _sikayetEkraniState();
}

class _sikayetEkraniState extends State<sikayetEkrani> {
  bool isvisible =  false ;
  String  met1 = " ";
    String met2  = " ";
    String met3  =  " ";
    String met4 =  " " ;
  TextEditingController metin1 = TextEditingController();
  TextEditingController metin2 = TextEditingController();
  TextEditingController metin3 = TextEditingController();
  TextEditingController metin4 = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Şikayetlerim'),
          centerTitle: true,
          foregroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Text('ürün adı',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                TextField(controller: metin1,),
                Text('ürün kodu',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                TextField(controller: metin2,),
                Text('şikayet konusu',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                TextField(controller: metin3,),
                Text('Şikayet',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                TextField(controller: metin4,),
                ElevatedButton(onPressed: (){ 
                 setState(() {
                   met1 = metin1.text ;
                   met2 = metin2.text;
                   met3 = metin3.text;
                   met4 = metin4.text;
                   isvisible = true;
                   
                 });
                }, child: Icon(Icons.add)),
                Visibility(
                  visible: isvisible == false ? false : true ,
                  child: Text('Oluşturulan Şikayet= $met1 $met2  $met3 $met4 ')),
                
              ],
          
          
            ),
          ),
        ),
      );
  }
}