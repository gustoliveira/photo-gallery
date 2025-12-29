import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:photo_gallery_app/main.dart';
import 'package:photo_gallery_app/models/photo.dart';
import 'package:photo_gallery_app/services/photo_service.dart';

// A fake PhotoService for widget tests allows precise control over the Future
class FakePhotoService extends PhotoService {
  final Future<List<Photo>> Function() _fetchPhotosOverride;

  // Pass a dummy MockClient to the super constructor.
  // It won't be used because we override fetchPhotos, but it satisfies the constructor.
  FakePhotoService(this._fetchPhotosOverride)
    : super(client: MockClient((request) async => http.Response('', 200)));

  @override
  Future<List<Photo>> fetchPhotos() {
    return _fetchPhotosOverride();
  }
}

void main() {
  group('PhotoService Unit Tests', () {
    test(
      'fetchPhotos returns a list of Photos if the http call completes successfully',
      () async {
        final client = MockClient((request) async {
          if (request.url.toString() == PhotoService.apiUrl) {
            return http.Response(
              json.encode([
                {
                  "id": "0",
                  "author": "Author 0",
                  "download_url": "https://picsum.photos/id/0/5000/3333",
                },
                {
                  "id": "1",
                  "author": "Author 1",
                  "download_url": "https://picsum.photos/id/1/5000/3333",
                },
              ]),
              200,
            );
          }
          return http.Response('Not Found', 404);
        });

        final photoService = PhotoService(client: client);
        final photos = await photoService.fetchPhotos();

        expect(photos.length, 2);
        expect(photos[0].id, "0");
        expect(photos[0].author, "Author 0");
        expect(photos[0].downloadUrl, "https://picsum.photos/id/0/5000/3333");
      },
    );

    test(
      'fetchPhotos throws an exception if the http call completes with an error',
      () async {
        final client = MockClient((request) async {
          return http.Response('Not Found', 404);
        });

        final photoService = PhotoService(client: client);

        expect(() => photoService.fetchPhotos(), throwsException);
      },
    );
  });

  group('PhotoGalleryScreen Widget Tests', () {
    testWidgets('PhotoGalleryScreen displays loading indicator initially', (
      WidgetTester tester,
    ) async {
      final completer = Completer<List<Photo>>();
      final fakePhotoService = FakePhotoService(() => completer.future);

      await tester.pumpWidget(
        MaterialApp(home: PhotoGalleryScreen(photoService: fakePhotoService)),
      );

      // Verify loading indicator is present
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('PhotoGalleryScreen displays error message on fetch failure', (
      WidgetTester tester,
    ) async {
      final fakePhotoService = FakePhotoService(
        () => Future.error(Exception('Failed to load photos')),
      );

      await tester.pumpWidget(
        MaterialApp(home: PhotoGalleryScreen(photoService: fakePhotoService)),
      );
      await tester
          .pumpAndSettle(); // Wait for FutureBuilder to complete with error

      expect(
        find.text('Error: Exception: Failed to load photos'),
        findsOneWidget,
      );
    });

    testWidgets('PhotoGalleryScreen displays photos in GridView', (
      WidgetTester tester,
    ) async {
      final List<Photo> mockPhotos = [
        Photo(
          id: "0",
          author: "Author 0",
          downloadUrl: "https://picsum.photos/id/0/5000/3333",
        ),
        Photo(
          id: "1",
          author: "Author 1",
          downloadUrl: "https://picsum.photos/id/1/5000/3333",
        ),
      ];

      final fakePhotoService = FakePhotoService(() async => mockPhotos);

      await tester.pumpWidget(
        MaterialApp(home: PhotoGalleryScreen(photoService: fakePhotoService)),
      );
      await tester
          .pumpAndSettle(); // Wait for FutureBuilder to complete with data

      // Verify that GridView is displayed
      expect(find.byType(GridView), findsOneWidget);

      // Verify that Cards are displayed for each photo
      expect(find.byType(Card), findsNWidgets(mockPhotos.length));

      // Verify that author names are displayed
      expect(find.text('Author 0'), findsOneWidget);
      expect(find.text('Author 1'), findsOneWidget);

      // Verify that favorite icons are displayed (initially unfavorite)
      expect(
        find.byIcon(Icons.favorite_border),
        findsNWidgets(mockPhotos.length),
      );
    });

    testWidgets('PhotoGalleryScreen handles favorite action', (
      WidgetTester tester,
    ) async {
      final List<Photo> mockPhotos = [
        Photo(
          id: "0",
          author: "Author 0",
          downloadUrl: "https://picsum.photos/id/0/5000/3333",
        ),
      ];

      final fakePhotoService = FakePhotoService(() async => mockPhotos);

      await tester.pumpWidget(
        MaterialApp(home: PhotoGalleryScreen(photoService: fakePhotoService)),
      );
      await tester.pumpAndSettle();

      // Tap the favorite icon
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle();

      // Verify that the icon changes to favorite
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsNothing);

      // Tap again to unfavorite
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();

      // Verify that the icon changes back to unfavorite
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
