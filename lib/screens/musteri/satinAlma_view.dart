import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/urun.dart';
import 'anaSayfa_view_model.dart';

class SatinAlmaView extends StatelessWidget {
  const SatinAlmaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.purple,
            )),
        centerTitle: true,
        title: Text(
          "Güvenli Alışveriş",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.shopping_cart,
            color: Colors.purple,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    'Teslimat Adresi',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
//todo Şu an için ürünle ilgili veriler geliyor. Normalde buraya adres bilgilerini getirip kutular içerisine yazdırıcaz. Ayrıca tıklama özelliği de ekliycez.
                  FutureBuilder<List<Urun>>(
                      future: Provider.of<AnasayfaViewModel>(context)
                          .tumUrunVerisiOkuma(),
                      builder: (centext, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: GridView.builder(
                              itemCount: snapshot.data?.length,
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.75,
                                crossAxisCount: 1,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black54,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Container(
                                width:
                                    MediaQuery.of(context).size.height * 0.20,
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
//*indicatorın boyutunu ayarlamak için transform scale kullanmak zorunda kaldım. Sizedbox bile işe yaramadı. Bu şekilde alana göre küçülttüm ve oldu.
                                child: Transform.scale(
                                    scale: 0.3,
                                    child: CircularProgressIndicator())),
                          );
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    'Ödeme',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Kayıtlı Kartlar',
                        style: TextStyle(),
                      ),
                      Text('Yeni Kart')
                    ],
                  )
                ],
              ),
            )),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          'Ödenecek Tutar',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Fiyat Gelecek',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ]),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Siparişi Onayla',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
