class Episodes {
  final int id;
  final int podcast_series_id;
  final int channelId;
  final String title;
  final int season;
  final int epnum;
  final String audio;
  final String art;
  final String description;
  final DateTime date;

  Episodes({
    required this.id,
    required this.podcast_series_id,
    required this.channelId,
    required this.title,
    required this.season,
    required this.epnum,
    required this.audio,
    required this.art,
    required this.description,
    required this.date,
  });

  factory Episodes.fromJson(Map<String, dynamic> parsedJson) {
    return Episodes(
      id: parsedJson['id'],
      podcast_series_id: parsedJson['podcast_series_id'],
      channelId: parsedJson['channels_id'],
      title: parsedJson['title'],
      season: parsedJson["season"],
      epnum: parsedJson["episode_number"],
      audio: parsedJson["audio_file"],
      art: parsedJson["clip_art"],
      description: parsedJson['description'],
      date: parsedJson['uploaded_at'],
    );
  }
}
