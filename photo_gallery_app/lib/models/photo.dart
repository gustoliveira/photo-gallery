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
      id: json['id'],
      author: json['author'],
      downloadUrl: json['download_url'],
    );
  }
}
