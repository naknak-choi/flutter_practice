import 'dart:convert';

import 'package:flutter_application_1/model/webtoon_detail_model.dart';
import 'package:flutter_application_1/model/webtoon_episode_model.dart';
import 'package:flutter_application_1/model/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    // 서버가 응답할 때 까지 기다리는게 해야함 get은 비동기 함수임 그래서 awit는 비동기 함수 내에 사용기능함
    // 데이터가 올 때까지 기다려야 할 때 사용함 그리고 get 은 Future 타입이라 미래에 오는 타입이다. 즉 미래에 완료되는 함수라는 것이고
    // 이 함수가 결국 Response를 반환한다는 걸 알 수 있다.
    final response = await http.get(url);

    // 서버에서 값을 가져오는 게 성공했다면 response.statuseCode는 200으로 반환되고 response.body 에 서버에서 받아온 값이 담아진다.
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
    }

    return webtoonInstances;
  }

  static Future<WebtoonDetailModel> getToonByID(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    // 서버가 응답할 때 까지 기다리는게 해야함 get은 비동기 함수임 그래서 awit는 비동기 함수 내에 사용기능함
    // 데이터가 올 때까지 기다려야 할 때 사용함 그리고 get 은 Future 타입이라 미래에 오는 타입이다. 즉 미래에 완료되는 함수라는 것이고
    // 이 함수가 결국 Response를 반환한다는 걸 알 수 있다.
    final response = await http.get(url);

    // 서버에서 값을 가져오는 게 성공했다면 response.statuseCode는 200으로 반환되고 response.body 에 서버에서 받아온 값이 담아진다.
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    // 서버가 응답할 때 까지 기다리는게 해야함 get은 비동기 함수임 그래서 awit는 비동기 함수 내에 사용기능함
    // 데이터가 올 때까지 기다려야 할 때 사용함 그리고 get 은 Future 타입이라 미래에 오는 타입이다. 즉 미래에 완료되는 함수라는 것이고
    // 이 함수가 결국 Response를 반환한다는 걸 알 수 있다.
    final response = await http.get(url);

    // 서버에서 값을 가져오는 게 성공했다면 response.statuseCode는 200으로 반환되고 response.body 에 서버에서 받아온 값이 담아진다.
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var epsoide in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(epsoide));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
