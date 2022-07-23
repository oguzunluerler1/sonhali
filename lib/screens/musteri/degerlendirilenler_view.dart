import 'package:flutter/material.dart';

class Degerlendirilenler extends StatelessWidget {
  const Degerlendirilenler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            Text('4'),
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
        ),
      ),
    );
  }
}
