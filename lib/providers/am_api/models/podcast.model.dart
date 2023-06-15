class Podcast {
  Podcast(
      {required this.image,
      required this.name,
      required this.author,
      this.description,
      required this.duration,
      required this.date});

  final String image;
  final String name;
  final String author;
  final String? description;
  final int duration;
  final DateTime date;

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      image: json['image'],
      name: json['title'],
      author: json['subtitle'],
      description: json['description'],
      duration: json['duration'],
      date: DateTime.parse(json['date']),
    );
  }
}
