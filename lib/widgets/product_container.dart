import 'package:flutter/material.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    Key? key, required this.onTap, required this.imageUrl,
  }) : super(key: key);

  final VoidCallback onTap;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height * 0.25,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: imageBorder(),
        child: productImage(url: imageUrl)
      ),
    );
  }

  BoxDecoration imageBorder() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black54,
      ),
    );
  }

  Image productImage({required String url}){
    return Image.network(
      url,
      errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline),
    );
  }

}