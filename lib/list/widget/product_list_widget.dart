import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingmall_platform/detail/product_detail.dart';
import 'package:shoppingmall_platform/models/product.dart'; // XFile을 사용하기 위한 import

class ProductListWidget extends StatelessWidget {
  final Product product;

  ProductListWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product),
          ),
        );
      },
      child: Column(children: [
        SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // 이미지
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        // AssetImage(product.images.first.path), // XFile의 경로를 사용
                        // AssetImage("assets/images/image_1.png"),
                        FileImage(File(product.images.first.path)),
                        // Image.file(
                        //   File(product.images.first.path),
                        //   fit: BoxFit.cover,
                        // ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(width: 12),
              // 내용
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.48,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.location,
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 11,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.44,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${product.price}원',
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.64,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.visibility,
                              size: 12, color: Color(0xFF767676)),
                          SizedBox(width: 2),
                          Text('12',
                              style: TextStyle(
                                  color: Color(0xFF767676),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      SizedBox(width: 8),
                      Row(children: [
                        Icon(Icons.favorite_border,
                            size: 12, color: Color(0xFF767676)),
                        SizedBox(width: 2),
                        Text('4',
                            style: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400))
                      ]),
                    ],
                  )
                ],
              ))
            ])),
        const SizedBox(height: 12),
        Divider(thickness: 0.5, color: Colors.grey[400])
      ]),
    );
  }
}
