import 'package:flutter/material.dart';

class kayitliKartView extends StatefulWidget {
  const kayitliKartView({Key? key}) : super(key: key);

  @override
  State<kayitliKartView> createState() => _kayitliKartViewState();
}

class _kayitliKartViewState extends State<kayitliKartView> {
  int kayitlikartsayisi = 3;
  int kayit1 = 1;
  int kayit2 = 1;
  int kayit3 = 1;
  bool kart1bool = true;
  bool kart2bool = true;
  bool kart3bool = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıtlı Kartlarım", style: TextStyle(color: Colors.purple),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){print("profil ekranına git");}, icon: Icon(Icons.person, color: Colors.purple,))
        ],
      ),
      body: bodyMethod(),
    );
  }

  Widget bodyMethod() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Kayıtlı Kartlarım ($kayitlikartsayisi)", style: TextStyle(color: Colors.red, fontSize: 30),),
          ),
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    kart1(),
                    kart2(),
                    kart3(),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: (){
                    (print("Adres ekleme ekranına geçilecek"));
                  }, icon: Icon(Icons.add)),
                  GestureDetector(onTap: (){(print("Adres ekleme ekranına geçilecek"));},child: Text("Adres Ekle"))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget kart2() {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: kartIciYazilar2(),
                ),
                height: 140,
                width: 200,
              ),
      ),
      visible: kart2bool == true ? true : false,
    );
  }

  Widget kart3() {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: kartIciYazilar3(),
                ),
                height: 140,
                width: 200,
              ),
      ),
      visible: kart3bool == true ? true : false
    );
  }

  Widget kart1() {
    return Visibility(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: kartIciYazilar1(),
                  ),
                  height: 140,
                  width: 200,
                ),
      ),
      visible: kart1bool == true ? true : false,
    );
  }

  Column kartIciYazilar1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/akbank.png",fit: BoxFit.contain,),
              height: 20,
              width: 70,
            ),
            Spacer(),
            GestureDetector(onTap: (){setState(() {
              kart1bool = false;
              kayitlikartsayisi=kayitlikartsayisi-1;
            });},child: Icon(Icons.delete))
          ],
        ),
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/axess.jpg", fit: BoxFit.contain,),
              height: 30,
              ),
            Spacer(),  
            Container(
              child: Image.asset("assets/kartlogolar/chip.jpg", fit: BoxFit.contain,),
              height: 30,
              ),  
          ],
        ),
        Text("4355 08** **** 2075"),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Text("Ali Ali"),
              Spacer(),
              Container(height: 15,child: Image.asset("assets/kartlogolar/visa.jpg"))
            ],
          ),
        )

        
      ],
    );
  }

    Column kartIciYazilar2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/iş.png",fit: BoxFit.contain,),
              height: 20,
              width: 70,
            ),
            Spacer(),
            GestureDetector(onTap: (){setState(() {
              kart2bool = false;
              kayitlikartsayisi=kayitlikartsayisi-kayit2;
            });},child: Icon(Icons.delete))
          ],
        ),
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/maximum.png", fit: BoxFit.contain,),
              height: 30,
              width: 100,
              ),
            Spacer(),  
            Container(
              child: Image.asset("assets/kartlogolar/chip.jpg", fit: BoxFit.contain,),
              height: 30,
              ),  
          ],
        ),
        Text("5891 82 **** 4371"),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Text("Veli Veli"),
              Spacer(),
              Container(height: 15,child: Image.asset("assets/kartlogolar/mastercard.png"))
            ],
          ),
        )

        
      ],
    );
  }


    Column kartIciYazilar3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/ziraat.png",fit: BoxFit.contain,),
              height: 20,
              width: 70,
            ),
            Spacer(),
            GestureDetector(onTap: (){setState(() {
              kart3bool = false;
              kayitlikartsayisi=kayitlikartsayisi-kayit1;
            });},child: Icon(Icons.delete))
          ],
        ),
        Row(
          children: [
            Container(
              child: Image.asset("assets/kartlogolar/bankkart.png", fit: BoxFit.contain,),
              height: 30,
              width: 100,
              ),
            Spacer(),  
            Container(
              child: Image.asset("assets/kartlogolar/chip.jpg", fit: BoxFit.contain,),
              height: 30,
              ),  
          ],
        ),
        Text("9999 88** **** 2222"),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Text("Asdf asdf"),
              Spacer(),
              Container(height: 15,child: Image.asset("assets/kartlogolar/mastercard.png"))
            ],
          ),
        )

        
      ],
    );
  }



}