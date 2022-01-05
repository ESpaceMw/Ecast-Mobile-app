class Charts {
  final int id;
  final String title;
  final String url;
  final String thumbnail;

  Charts({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnail,
  });

  factory Charts.fromJson(Map<String, dynamic> parsedJon) {
    return Charts(
        id: parsedJon['id'],
        title: parsedJon['title'],
        url: parsedJon['url'],
        thumbnail: parsedJon['thumbnailUrl']);
  }
}
