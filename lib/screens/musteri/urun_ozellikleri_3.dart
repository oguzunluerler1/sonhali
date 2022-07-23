import 'package:flutter/material.dart';

class IptalVeIadeKosullari extends StatefulWidget {
  const IptalVeIadeKosullari({Key? key}) : super(key: key);

  @override
  State<IptalVeIadeKosullari> createState() => _IptalVeIadeKosullariState();
}

class _IptalVeIadeKosullariState extends State<IptalVeIadeKosullari> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
          "     Satıcı, cayma bildiriminin kendisine ulaşmasından itibaren en geç 14 günlük süre içerisinde toplam bedeli ve alıcıyı borç altına sokan belgeleri alıcıya iade etmek ve 20 günlük süre içerisinde malı iade almakla yükümlüdür.          Alıcının kusurundan kaynaklanan bir nedenle malın değerinde bir azalma olursa veya iade imkânsızlaşırsa alıcı kusuru oranında satıcının zararlarını tazmin etmekle yükümlüdür. Cayma hakkının kullanılması nedeniyle SATICI tarafından düzenlenen kampanya limit tutarının altına düşülmesi halinde kampanya kapsamında faydalanılan indirim miktarı iptal edilir.www.detayyayin.com.tr adresinden satışı gerçekleşen kitaplar, CAYMA HAKKI KULLANILAMAYACAK ürünlerde bulunmasından dolayı, CAYMA HAKKI KULLANILAMAZ.          Alıcı, siparişinin iptali için siparişini onayladığı günün mesai bitimine kadar, telefon, fax, eposta veya telefon ile satıcıya bildirmesi gerekmektedir.          Alıcı, ürünlerin ayıplı olması durumunda, siparişin iptalini veya ürünün aynısı ile değiştirilmesini talep edebilir.",
          textWidthBasis: TextWidthBasis.longestLine,
          textAlign: TextAlign.justify),
    );
  }
}
