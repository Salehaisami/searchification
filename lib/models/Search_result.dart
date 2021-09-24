import 'package:equatable/equatable.dart';


class SearchResultImage extends Equatable{
  final String? thumbnailUrl;
  final String? originalUrl;
  final String? link;
  final String? sourceWebsite;
  final String? title;

  const SearchResultImage({
  this.thumbnailUrl,
  this.originalUrl,
  this.link,
  this.sourceWebsite,
    this.title
});

  factory SearchResultImage.fromJson(Map json) {
    return SearchResultImage(
        thumbnailUrl: json['thumbnail'],
        originalUrl: json['original'],
        link: json['link'],
        sourceWebsite: json['source'],
        title: json['title']
    );
  }

  @override
  List<String?> get props => [thumbnailUrl, originalUrl, link, sourceWebsite, title];

}
