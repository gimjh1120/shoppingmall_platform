import 'package:flutter/material.dart';

class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/image_1.png'), // 일단 이미지 하나로 지정
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
                          '아이폰13프로 128G 화이트 풀박 ‼카메라 무음‼️',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.48,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // 텍스트가 너무 길어지면 ... 으로
                          maxLines: 1, // 텍스트 최대 줄 수 1개로 설정
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '서울, 관악구 - 12시간 전',
                          style: TextStyle(
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
                      '600,000원',
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.64,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 12,
                              color: Color(0xFF767676),
                            ),
                            const SizedBox(width: 2), // 아이콘이랑 텍스트 사이간격 2
                            Text(
                              '12',
                              style: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8), // [아이콘 텍스트] 끼리의 사이간격 8
                        // Heart icon and text
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 12,
                              color: Color(0xFF767676),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '4',
                              style: TextStyle(
                                color: Color(0xFF767676),
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12), // 위젯과 라인 사이 간격 12
        Divider(
          thickness: 0.5,
          color: Colors.grey[400],
        ),
      ],
    );
  }
}
