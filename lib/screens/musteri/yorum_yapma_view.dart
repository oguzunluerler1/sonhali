import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class YorumYapma extends StatelessWidget {
  const YorumYapma({Key? key}) : super(key: key);

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
          "Değerlendir",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text('ürün ismi'),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text('genel puanı'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('kaç kez değerlendirildiği')
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    //borderRadius: BorderRadius.circular(20),
                    /* border: Border.all(
                            color: Colors.black54,
                          ), */
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Ürünü Değerlendir'),
            SizedBox(
              height: 10,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            Text('Ürün hakkındaki düşünceleriniz.'),
            TextField(
//*Çoklu satır seçince satır sonu aşağı iniyor. Maxlines'a null deyince de satır sayısı sınırsız oluyor.
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              maxLength: 2000,
            ),
            Text('Ürün Fotoğrafı Ekle'),
            Container(
              height: MediaQuery.of(context).size.width * .2,
              width: MediaQuery.of(context).size.width * .2,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.photo_camera),
              ),
            ),
//*Kalan boşluğu dolduruyor. Enteresan bir widget. Sütunda kalan boşluğu tamamladı bu sayede son eleman sayfa altına sabitlenebildi.
            Spacer(),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.7, 40)),
                    onPressed: () {},
                    child: Text(
                      'Değerlendir',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
