import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudwalk/models/photo.dart';
import 'package:cloudwalk/providers/photo_provider.dart';
import 'package:cloudwalk/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late PhotoProvider provider;
  late MockApiService mockApiService;

  setUp(() async {
    mockApiService = MockApiService();
    SharedPreferences.setMockInitialValues({});
    provider = PhotoProvider(apiService: mockApiService);
  });

  group('PhotoProvider', () {
    test('initial state should be empty', () {
      expect(provider.photos, []);
      expect(provider.isLoading, false);
      expect(provider.error, null);
    });

    test('loadPhotos should fetch photos and update state', () async {
      final photos = [
        Photo(id: '0', author: 'Author 1', downloadUrl: 'url1'),
        Photo(id: '1', author: 'Author 2', downloadUrl: 'url2'),
      ];

      when(() => mockApiService.fetchPhotos()).thenAnswer((_) async => photos);

      await provider.loadPhotos();

      expect(provider.photos.length, 2);
      expect(provider.isLoading, false);
      expect(provider.photos[0].author, 'Author 1');
    });

    test('toggleFavorite should update photo state and persist', () async {
      final photos = [
        Photo(id: '0', author: 'Author 1', downloadUrl: 'url1'),
      ];
      when(() => mockApiService.fetchPhotos()).thenAnswer((_) async => photos);

      await provider.loadPhotos();
      expect(provider.photos[0].isFavorite, false);

      await provider.toggleFavorite('0');
      expect(provider.photos[0].isFavorite, true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getStringList('favorite_ids'), ['0']);
    });

    test('loadPhotos should handle errors', () async {
      when(() => mockApiService.fetchPhotos()).thenThrow(Exception('Fetch failed'));

      await provider.loadPhotos();

      expect(provider.isLoading, false);
      expect(provider.error, contains('Fetch failed'));
    });
  });
}
