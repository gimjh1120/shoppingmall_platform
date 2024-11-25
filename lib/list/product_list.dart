import 'package:flutter/material.dart';
import 'package:shoppingmall_platform/list/widget/product_list_widget.dart';
import 'package:shoppingmall_platform/models/product.dart';
import 'package:shoppingmall_platform/registration/product_registration.dart'; // XFile을 사용하기 위한 import

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Product> products = [
    // Product(
    //   title: '아이폰13프로 128G 화이트 풀박 ‼카메라 무음‼️',
    //   location: "서울시 강남구",
    //   detail: '아이폰13프로 128G 화이트 풀박\n\n카메라 무음\n\n애플케어플러스 22년 10월까지',
    //   price: 600000,
    //   images: [XFile('assets/images/image_1.png')],
    // ),
    // 추가 상품들을 여기에 정의할 수 있습니다.
  ];
  
  void addProduct(Product newProduct) {
    setState(() {
      products.add(newProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'Banana',
              style: TextStyle(
                color: Color(0xFFFF6E1D),
                fontSize: 28,
                fontFamily: 'Squada One',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.56,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 20),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductListWidget(product: products[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 2),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductRegistration(addProduct: addProduct),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E1D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  '글쓰기',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}