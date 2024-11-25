import 'package:flutter/material.dart';
import 'package:shoppingmall_platform/detail/product_detail.dart';
import 'package:shoppingmall_platform/list/product_list.dart';
import 'package:shoppingmall_platform/registration/product_registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductList()
    );
  }
}