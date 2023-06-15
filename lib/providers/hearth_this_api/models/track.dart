// ignore_for_file: non_constant_identifier_names

import 'package:amare/providers/hearth_this_api/models/user.dart';

class Track {
  Track({
    this.image,
    this.image_large,
    required this.name,
    required this.author,
    this.description,
    required this.genre,
    required this.duration,
    required this.date,
    this.stream_url,
  });

  final String? image;
  final String? image_large;
  final String name;
  final User author;
  final String? description;
  final String genre;
  final String duration;
  final DateTime date;
  final String? stream_url;

  int get duration_secods {
    return int.parse(duration);
  }

  double get duration_minutes {
    return (int.parse(duration)) / 60;
  }

  String get duration_string {
    var durationSecs = int.parse(duration);
    var minutes = ((durationSecs) / 60).floor();
    var seconds = durationSecs % 60;

    return "$minutes min $seconds sec";
  }

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      image: json['thumb'],
      image_large: json['artwork_url'],
      name: json['title'],
      author: User.fromJson(json['user']),
      description: json['description'],
      genre: json['genre'],
      duration: json['duration'],
      date: DateTime.parse(json['release_date']),
      stream_url: json['stream_url'],
    );
  }

  Track.fromJsonProcessed(Map<String, dynamic> json)
      : image = json['image'],
        image_large = json['image_large'],
        name = json['name'],
        author = User.fromJsonProcessed(json['author']),
        description = json['description'],
        genre = json['genre'],
        duration = json['duration'],
        date = DateTime.parse(json['date']),
        stream_url = json['stream_url'];

  Map<String, dynamic> toJson() => {
        'image': image,
        'image_large': image_large,
        'name': name,
        'author': author.toJson(),
        'description': description,
        'genre': genre,
        'duration': duration,
        'date': date.toIso8601String(),
        'stream_url': stream_url,
      };
}
