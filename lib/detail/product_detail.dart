import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(); // PageView 컨트롤러 추가
  int currentPage = 0; // 현재 슬라이더 페이지를 저장하는 변수

  List<String> images = [
    'https://via.placeholder.com/600x400', // 이미지 URL 1
    'https://via.placeholder.com/600x400/ff0000', // 이미지 URL 2
    'https://via.placeholder.com/600x400/00ff00', // 이미지 URL 3
  ];
  String title = '제목';
  String productDetail =
      '상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명상품 상세 설명';
  int productPrice = 20000;
  bool like = false; // 좋아요 상태를 저장하는 변수

  @override
  void dispose() {
    scrollController.dispose(); // ScrollController 해제
    pageController.dispose(); // PageController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController, // 스크롤 가능한 영역을 위한 컨트롤러
        slivers: [
          SliverAppBar(
            expandedHeight: 300, // AppBar의 확장 높이 설정
            pinned: true, // 상단바를 고정
            //이미지 및 인디케이터 영역
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double appBarHeight = constraints.biggest.height;
                bool isVisiual = appBarHeight > 150;

                return Stack(
                  children: [
                    FlexibleSpaceBar(
                      background: _buildImageSlider(), //이미지
                    ),
                    if (isVisiual) //현재 앱바 높이가 150보다 클때 인디케이터 노출
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        //인디케이터
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: currentPage == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
            //뒤로가기 버튼
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상품 제목
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    // "상품 설명" 제목
                    Text(
                      '상품 설명',
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 5),
                    // 상세 설명 텍스트
                    Text(
                      productDetail,
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
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black87, // 상단 테두리 색상
              width: 0.1, // 상단 테두리 두께
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // 좋아요 아이콘
              GestureDetector(
                onTap: () {
                  setState(() {
                    like = !like; // 좋아요 상태 토글
                  });
                },
                child: Icon(
                  like
                      ? Icons.favorite
                      : Icons.favorite_border, // 좋아요 상태에 따라 아이콘 변경
                  size: 32,
                  color: Color(0xFFFF6E1D), // 좋아요 아이콘 색상
                ),
              ),
              SizedBox(width: 24),
              // 상품 가격
              Text(
                '$productPrice 원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // 주문하기 버튼
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '주문하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글게
                  ),
                  backgroundColor: Color(0xFFFF6E1D), // 버튼 색상
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지 슬라이더 빌드
  Widget _buildImageSlider() {
    return PageView.builder(
      controller: pageController, // 페이지를 제어하기 위한 컨트롤러
      itemCount: images.length, // 이미지 개수
      onPageChanged: (index) {
        setState(() {
          currentPage = index; // 현재 페이지 업데이트
        });
      },
      itemBuilder: (context, index) {
        return Image.network(
          images[index],
          fit: BoxFit.cover, // 이미지를 슬라이더에 꽉 채우기
        );
      },
    );
  }
}

