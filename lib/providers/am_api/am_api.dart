library am_api;

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:amare/providers/am_api/models/podcast.model.dart';

class _AMApiRoutes {
  static const _baseUrl = "https://run.mocky.io/v3";
  static final podcasts =
      Uri.parse(_baseUrl + "/4f5f02d1-7c2f-4518-8503-267eb758aa3c");
}

class AMApi {
  Future<List<Podcast>> fetchPodcasts() async {
    final response = await http.get(_AMApiRoutes.podcasts);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var podcasts = body['podcasts'];

      return List.from(podcasts)
          .map((podcast) => Podcast.fromJson(podcast))
          .toList();
    } else {
      return [];
    }
  }
}
