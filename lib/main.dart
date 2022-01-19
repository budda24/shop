import 'package:flutter/material.dart';
import 'package:shop/screeans/edit_product_screen.dart';

import 'screeans/cart_screean.dart';
import 'screeans/product_details_screan.dart';
import 'screeans/product_overview_screean.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'screeans/orders_screen.dart';
import 'screeans/user_producs_screen.dart';



void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        home: ProductsScreean(),
        initialRoute: ProductsScreean.id,
        routes: {
          ProductsScreean.id: (ctx) => ProductsScreean(),
          ProductDetails.id: (ctx) => ProductDetails(),
          CartScrean.id: (ctx) => CartScrean(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen()

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
        title: const Text(
          'MyShop',
          style: kTextTitle,
        ),
      ),
      body: const Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}
