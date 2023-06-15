library hearth_this_api;

import 'dart:convert';
import 'package:amare/providers/hearth_this_api/models/playlist.dart';
import 'package:amare/providers/hearth_this_api/models/track.dart';
import 'package:http/http.dart' as http;

class _HearthThisApiRoutes {
  final _baseUrl = "https://api-v2.hearthis.at";
  String username;

  _HearthThisApiRoutes(this.username);

  tracks(int page, int count) {
    return Uri.parse(
        _baseUrl + "/$username/?type=tracks&page=$page&count=$count");
  }

  playlists(int page, int count) {
    return Uri.parse(
        _baseUrl + "/$username/?type=playlists&page=$page&count=$count");
  }

  setFromPlaylist(Playlist playlist, int page, int count) {
    return Uri.parse(
        _baseUrl + "/set/${playlist.permalink}?page=$page&count=$count");
  }
}

class HearthThisApi {
  String username;
  late _HearthThisApiRoutes routes;

  HearthThisApi(this.username) {
    routes = _HearthThisApiRoutes(username);
  }

  Future<List<Playlist>> fetchPlaylists(int page, [count = 10]) async {
    final response = await http.get(routes.playlists(page, count));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return List.from(body)
          .map((podcast) => Playlist.fromJson(podcast))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Track>> fetchTracks(int page, [count = 10]) async {
    final response = await http.get(routes.tracks(page, count));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return List.from(body).map((podcast) => Track.fromJson(podcast)).toList();
    } else {
      return [];
    }
  }

  Future<List<Track>> fetchSet(Playlist playlist, int page,
      [count = 10]) async {
    final response =
        await http.get(routes.setFromPlaylist(playlist, page, count));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return List.from(body).map((podcast) => Track.fromJson(podcast)).toList();
    } else {
      return [];
    }
  }
}
