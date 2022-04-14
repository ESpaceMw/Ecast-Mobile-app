class Charts {
  final int id;
  final String name;
  final String description;
  final String thumbnail;

  Charts({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory Charts.fromJson(Map<String, dynamic> parsedJon) {
    return Charts(
      id: parsedJon['id'],
      name: parsedJon['name'],
      description: parsedJon['description'],
      thumbnail: parsedJon['header_image'],
    );
  }
}
