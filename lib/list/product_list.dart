import 'package:flutter/material.dart';
import 'package:shoppingmall_platform/list/widget/product_list_widget.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 배경 흰색 설정
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // 이게 뭔지 잘 모르겠슴..
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 앱 바의 배경색 흰색
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // 그림자 컬러
                blurRadius: 12, // 블러 12
                offset: Offset(0, 4), // 그림자 위치 x,y
              ),
            ],
          ),
          child: AppBar(
            title: Text(
              'Banana',
              style: TextStyle(
                color: Color(0xFFFF6E1D),
                fontSize: 28,
                fontFamily: 'Squada One',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.56, // 자간
              ),
            ),
            backgroundColor: Colors.transparent, // 스크롤 했을때 그림자가 생기는거 같음
            elevation: 0, // 기본 그림자 비활성화
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), //좌우 패딩 20
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 20), // 첫번째 위젯과 앱바 사이의 간격
          itemCount: 10, // 일단 위젯 10개 복사
          itemBuilder: (context, index) {
            return ProductListWidget();
          },
          separatorBuilder: (context, index) =>
              SizedBox(height: 12), // 선이랑 위젯 사이 간격
        ),
      ),

      // 글쓰기 버튼
      floatingActionButton: Align(
        alignment: Alignment.bottomRight, // 오른쪽 하단에 버튼 위치
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 12, // 하단에서 12 간격 띄움
            right: 2, // 오른쪽에서 2 간격 띄움
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF6E1D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white, // Icon color
                ),
                const SizedBox(width: 4), // Spacing between icon and text
                Text(
                  '글쓰기',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
