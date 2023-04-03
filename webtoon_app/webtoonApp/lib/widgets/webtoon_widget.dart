import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector 로 클릭에 관한 모든 이벤트 감지 가능
    return GestureDetector(
      onTap: () {
        // route는 statelessWidget인 스크린을 애니메이션으로 싸서 렌더 하는것. 거기서 필요한게 MaterialPageRoute이다 얘는 builder를 필요로하는 데
        // builder는 route를 만드는 함수이다.
        // Navigator은 원하는 녀석을 화면에 올려준다.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
