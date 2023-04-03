import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/webtoon_detail_model.dart';
import 'package:flutter_application_1/model/webtoon_episode_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likeToons = prefs.getStringList('likedToons');
    if (likeToons != null) {
      if (likeToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likeToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonByID(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likeToons = prefs.getStringList('likedToons');
    if (likeToons != null) {
      if (isLiked) {
        likeToons.remove(widget.id);
      } else {
        likeToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likeToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Hero(
                        tag: widget.id,
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
                          child: Image.network(widget.thumb),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoonDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Text('...');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoonId: widget.id,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
