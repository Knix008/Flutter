import 'package:flutter/material.dart';
import 'package:product_nav_app/product.dart';
import 'package:product_nav_app/productbox.dart';
import 'package:product_nav_app/ratingbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Navigation Demo Home Page'),
    );
  }
}

@immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final items = Product.getProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Product Navigation")),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ProductBox(item: items[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(item: items[index]),
                  ),
                );
              },
            );
          },
        ));
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key, required this.item}) : super(key: key);
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/" + item.image),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(item.description),
                            Text("Price: " + item.price.toString()),
                            const RatingBox(),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}
