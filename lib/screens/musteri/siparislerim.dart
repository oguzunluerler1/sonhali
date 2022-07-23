import 'package:flutter/material.dart';

class siparislerView extends StatefulWidget {
  const siparislerView({Key? key}) : super(key: key);

  @override
  State<siparislerView> createState() => _siparislerViewState();
}

class _siparislerViewState extends State<siparislerView> {
  bool onTapDegiskeni=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        title: Text("Hepsiburada - Siparişlerim", style: TextStyle(color: Colors.purple)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              print("profil ekranına götürülecek");
            }, 
            child: Padding( 
              padding: const EdgeInsets.all(15.0), 
              child: Icon(Icons.person, color: Colors.purple),
            ),
          ),
        ],
      ),
      body: bodyMethod(), 
    );
  }

  Widget bodyMethod() {
    return Column(
      children: [
        ustSiparisTalepSecimMetodu(),
        Expanded(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  gestureDetectorIcKutuFull(),
                  gestureDetectorIcKutuFull(),
                  gestureDetectorIcKutuFull(),
                  gestureDetectorIcKutuFull(),
                  gestureDetectorIcKutuFull(),
                  gestureDetectorIcKutuFull(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget gestureDetectorIcKutuFull() {
    return SizedBox(width: double.infinity, height: MediaQuery.of(context).size.height * 0.36,
                  child: IcKutuFull(),
                  );
  }

  Column IcKutuFull() {
    return Column(
                    children: [
                      IcKutuUst(),
                      IcKutuAlt()
                    ],
                  );
  }

  Container IcKutuAlt() {
    return Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.2, color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: IcKutuAltBolgeIci(),
                        ),
                      ), 
                    );
  }

  Widget IcKutuAltBolgeIci() {
    return Container(
      child: GestureDetector(
        onTap: (){
          print("Sipariş detayı ekranına gidilecek");
        },
        child: Column(
          children: [
            Container(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Spacer(),
                    Center(child: CircleAvatarMetodu()),
                    Spacer(),
                    Container(
                      child: Column(
                        children: [
                          Spacer(),
                          Text("6 Haziran"),
                          Spacer(),
                          Text("Pts, 10:40"),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Spacer(),
                              Text("179,00 TL",style: TextStyle(color: Colors.green.shade900),),
                              Spacer(),
                              Text("Hepsipay Cüzdanım"),
                              Spacer(),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.done),
                        SizedBox(width: 4,),
                        Text("Sipariş tamamlandı"),
                      ],
                    ),
                    TextButton(onPressed: (){}, child: Text("Değerlendir"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5),
        ),
    );
  }

  Container IcKutuUst() {
    return Container(
      width: double.infinity, 
      height: MediaQuery.of(context).size.height * 0.15, 
      color: Colors.blue.shade200, 
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  Spacer(),
                  Text("Haziran", style: TextStyle(fontSize: 25, color: Colors.purple),),
                  Spacer(),
                ],
              ), 
              Spacer(),
              Icon(Icons.sunny)
            ],
          ),
        ),
      ),
    
    );
  }

  CircleAvatar CircleAvatarMetodu() {
    return CircleAvatar(backgroundImage: NetworkImage("https://productimages.hepsiburada.net/s/10/500/9198908342322.jpg"));
  }

  Row ustSiparisTalepSecimMetodu() {
    return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  print("sipariş ekranına yönlendir");
                  setState(() {
                    onTapDegiskeni = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(border: Border(
                    bottom: BorderSide(width: onTapDegiskeni == false? 2 :0, color: Colors.black,),
                  )),
                  child: Center(child: Text("Siparişlerim", textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: onTapDegiskeni==false? FontWeight.bold :FontWeight.normal),)),
                ),
              ),
            )
          ),           
          Expanded(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: GestureDetector(   
                child: Container(
                  decoration: BoxDecoration(border: Border(
                    bottom: BorderSide(width: onTapDegiskeni == true? 2 :0, color: Colors.black,),
                  )),
                  child: Center(child: Text("Taleplerim", textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: onTapDegiskeni==true? FontWeight.bold :FontWeight.normal),)),
                ),
                onTap: () {
                  print("taleplerim ekranına yönlendir");
                  setState(() {
                    onTapDegiskeni = true;
                  });
                },
              ),
            )
          ),  
        ],
      );
  }
}