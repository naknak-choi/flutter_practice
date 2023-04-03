import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoonId,
  }) : super(key: key);

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/list?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.green.shade400,
          border: Border.all(
            strokeAlign: StrokeAlign.center,
            color: Colors.red,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: const Offset(10, 10),
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
