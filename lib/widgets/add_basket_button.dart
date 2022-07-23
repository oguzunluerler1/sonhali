import 'package:flutter/material.dart';
import 'package:idea_ecommerce_app/models/urun.dart';
import 'package:idea_ecommerce_app/providers/basket_provider.dart';
import 'package:provider/provider.dart';
import '../app_constants/app_strings.dart';

class AddBasketButton extends StatelessWidget {
  const AddBasketButton({
    Key? key, required this.urun,
  }) : super(key: key);

  final Urun urun;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        sepeteEkleFirebaase(context);
      },
      child: Text(sepeteEkleText)
    );
  }

  void sepeteEkleFirebaase(BuildContext context) async {
    await context.read<BasketProvider>().addItemToBasket(urun);
    await context.read<BasketProvider>().getBasket();
  }

}