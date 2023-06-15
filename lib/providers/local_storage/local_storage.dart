// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:amare/providers/hearth_this_api/models/track.dart';
import 'package:shared_preferences/shared_preferences.dart';

const RECENTLY_PLAYED_KEY = "RECENTLY_PLAYED_KEY";

class LocalStorageProvider {
  static saveRecentlyPlayed(Track track) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> list = _restoreRecentlyPlayed(prefs);

    final encoded = json.encode(track.toJson());

    if (!list.contains(encoded)) {
      list.add(encoded);
    }

    await prefs.setStringList(RECENTLY_PLAYED_KEY, list);
  }

  static List<String> _restoreRecentlyPlayed(SharedPreferences prefs) {
    final list = prefs.getStringList(RECENTLY_PLAYED_KEY) ?? [];
    return list;
  }

  static Future<List<Track>> get recentlyPlayed async {
    final prefs = await SharedPreferences.getInstance();
    final list = _restoreRecentlyPlayed(prefs);

    return list
        .map((jsonString) => Track.fromJsonProcessed(json.decode(jsonString)))
        .toList();
  }
}
