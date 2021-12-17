import 'package:flutter/material.dart';

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

// class Photo {
//   final int albumId;
//   final int id;
//   final String title;
//   final String url;
//   final String thumbnailUrl;

//   const Photo({
//     required this.albumId,
//     required this.id,
//     required this.title,
//     required this.url,
//     required this.thumbnailUrl,
//   });

//   factory Photo.fromJson(Map<String, dynamic> json) {
//     return Photo(
//       albumId: json['albumId'] as int,
//       id: json['id'] as int,
//       title: json['title'] as String,
//       url: json['url'] as String,
//       thumbnailUrl: json['thumbnailUrl'] as String,
//     );
//   }
// }
