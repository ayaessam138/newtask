import 'package:newtask/core/utility.dart';

class AlbumModel {
  final String url;
  final String title;
  final String thumbnailUrl;
  bool isExpanded = false;

  AlbumModel(
      {required this.url, required this.title, required this.thumbnailUrl});

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
        url: json['url'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}
