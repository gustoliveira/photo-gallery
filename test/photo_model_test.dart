import 'package:flutter_test/flutter_test.dart';
import 'package:cloudwalk/models/photo.dart';

void main() {
  group('Photo Model', () {
    test('should create Photo from JSON', () {
      final json = {
        'id': '0',
        'author': 'Alejandro Escamilla',
        'download_url': 'https://picsum.photos/id/0/5000/3333'
      };

      final photo = Photo.fromJson(json);

      expect(photo.id, '0');
      expect(photo.author, 'Alejandro Escamilla');
      expect(photo.downloadUrl, 'https://picsum.photos/id/0/5000/3333');
      expect(photo.isFavorite, false);
    });

    test('should convert Photo to JSON', () {
      final photo = Photo(
        id: '1',
        author: 'John Doe',
        downloadUrl: 'https://example.com/photo.jpg',
      );

      final json = photo.toJson();

      expect(json['id'], '1');
      expect(json['author'], 'John Doe');
      expect(json['download_url'], 'https://example.com/photo.jpg');
    });
  });
}
