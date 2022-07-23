import 'package:flutter/material.dart';

import 'degerlendirilenler_view.dart';
import 'degerlendirmeBekleyenler_view.dart';

class YorumlarView extends StatelessWidget {
  const YorumlarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.deepPurple,
            title: Text(
              "Değerlendirmelerim",
              style: TextStyle(
                  color: Colors.deepPurple, fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
                padding: EdgeInsets.all(8),
                labelColor: Colors.purple,
                tabs: [
                  Tab(
                    text: 'Değerlendirilenler',
                  ),
                  Tab(
                    text: 'Değerlendirme Bekleyenler',
                  )
                ]),
          ),
          body: TabBarView(children: [
            Degerlendirilenler(),
            DegerlendirmeBekleyenler(),
          ])
      
          /* Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 30,
                        )
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  //borderRadius: BorderRadius.circular(20),
                  /* border: Border.all(
                    color: Colors.black54,
                  ), */
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
                                  Text('değerlendirme puanı yıldızla'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('yorum tarihi')
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Yorum metni gelecek')],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  //borderRadius: BorderRadius.circular(20),
                  /* border: Border.all(
                    color: Colors.black54,
                  ), */
                ),
              )),
            ),
          ],
        ), */
          ),
    );
  }
}
