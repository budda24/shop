import 'package:flutter/material.dart';
import 'package:shop/providers/auth_provider.dart';
import 'package:shop/screeans/edit_product_screen.dart';

import 'screeans/auth_screen.dart';
import 'screeans/cart_screean.dart';
import 'screeans/product_details_screan.dart';
import 'screeans/product_overview_screean.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'screeans/orders_screen.dart';
import 'screeans/splash_screen.dart';
import 'screeans/user_producs_screen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          create:(_)=>Products(),
          update: (_, auth, priviousproduct ) => Products(token: auth.token, userId: auth.userId),
        ),
        /* to extend provider with other provider below on the widget tree */
         ChangeNotifierProxyProvider<Auth,Cart>(
          create:(_)=> Cart(),
          update: (context, auth,_)=> Cart(auth: auth),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: Consumer<Auth>(builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          /* checking if user is auth. if not returning future builder trigering auto login where the shared_preferences will be checket for valid auth. data */
          home: !value.userIsAuthenticated? FutureBuilder(future: value.checkLogIn(),
         /*  if future return true ConnectionState == done */
           builder: (context, snapshot) =>snapshot.connectionState == ConnectionState.waiting
          ? SplashScreen()
          : ProductsScreean())
          :ProductsScreean(),
          routes: {
            ProductsScreean.id: (ctx) => ProductsScreean(),
            ProductDetails.id: (ctx) => ProductDetails(),
            CartScrean.id: (ctx) => CartScrean(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen()
          },
        );
      }),
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
