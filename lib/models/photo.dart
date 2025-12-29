class Photo {
  final String id;
  final String author;
  final String downloadUrl;
  bool isFavorite;

  Photo({
    required this.id,
    required this.author,
    required this.downloadUrl,
    this.isFavorite = false,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      author: json['author'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'download_url': downloadUrl,
    };
  }
}
