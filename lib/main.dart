import 'package:flutter/material.dart';


import 'screeans/product_details_screan.dart';
import 'screeans/product_overview_screean.dart';
import 'package:provider/provider.dart';

import 'package:shop/const.dart';
import 'providers/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        home: ProductsScreean(),
        initialRoute: ProductsScreean.id,
        routes: {
          ProductsScreean.id: (ctx) => ProductsScreean(),
          ProductDetails.id: (ctx) => ProductDetails(),

        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorMain,
        centerTitle: true,
        title: Text('MyShop', style: kTextTitle,),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
