import 'package:flutter/material.dart';
import 'package:product_nav_app/product.dart';
import 'package:product_nav_app/ratingbox.dart';

class ProductBox extends StatelessWidget {
  const ProductBox({Key ? key, required this.item}) : super(key: key);
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/" + item.image),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.name,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(item.description),
                            Text("Price: " + item.price.toString()),
                            const RatingBox(),
                          ],
                        )
                    )
                )
              ]
          ),
        )
    );
  }
}