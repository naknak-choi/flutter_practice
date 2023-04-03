import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/webtoon_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  // const 는 컴파일 이전에 값을 알고 있을 때 사용한다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          "Today's Toons",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // FutureBuilder 이게 데이터가 올때까지 기다리게 하고 future와 builder을 통해 데이터를 다룰 수 있게 해준다
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var webtoon = snapshot.data![index];
          return Webtoon(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
        itemCount: snapshot.data!.length);
  }
}
