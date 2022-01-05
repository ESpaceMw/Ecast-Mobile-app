
class Channels {
  final int id;
  final String title;
  final String url;
  final String thumbnail;

  Channels({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
  });

  factory Channels.fromJson(Map<String, dynamic> parsedJon) {
    return Channels(
        id: parsedJon['id'],
        title: parsedJon['title'],
        url: parsedJon['url'],
        thumbnail: parsedJon['thumbnailUrl']);
  }
}

