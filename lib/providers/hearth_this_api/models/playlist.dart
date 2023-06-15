import 'package:amare/providers/hearth_this_api/models/user.dart';

class Playlist {
  Playlist({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.author,
    required this.permalink,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final User author;
  final String permalink;

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      image: json['thumb'],
      author: User.fromJson(json['user']),
      permalink: json['permalink'],
    );
  }
}
