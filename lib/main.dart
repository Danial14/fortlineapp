import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fortline_app/Screen/All_products.dart';
import 'package:fortline_app/Screen/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'Screen/Splash_Screen.dart';


void main(){

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx){
        return ProductsProvider();
      })
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortline Customer App',

      home: AllProducts()//SplashScreen(),
    ),
    );
  }
}



