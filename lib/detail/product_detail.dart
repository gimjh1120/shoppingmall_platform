import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final List<String> images = [
    'https://via.placeholder.com/600x400', // 이미지 URL 1
    'https://via.placeholder.com/600x400/ff0000', // 이미지 URL 2
    'https://via.placeholder.com/600x400/00ff00', // 이미지 URL 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          SliverAppBar(
            expandedHeight: 300, // 초기 확장 높이
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageSlider(), // 슬라이드 추가
            ),
            leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // 아래 콘텐츠 영역
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '제목',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '상품 설명',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '상세설명',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 32,
                color: Color(0xFFFF6E1D),
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                '가격 원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '주문하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Color(0xFFFF6E1D),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 이미지 슬라이더 빌드
  Widget _buildImageSlider() {
    return PageView.builder(
      itemCount: images.length, // 이미지 개수
      itemBuilder: (context, index) {
        return Image.network(
          images[index],
          fit: BoxFit.cover, // 이미지를 슬라이더에 꽉 채우기
        );
      },
    );
  }
}
