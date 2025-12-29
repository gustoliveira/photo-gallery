import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudwalk/models/photo.dart';
import 'package:cloudwalk/providers/photo_provider.dart';
import 'package:cloudwalk/screens/photo_grid_screen.dart';
import 'package:cloudwalk/services/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    SharedPreferences.setMockInitialValues({});
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider(
      create: (_) => PhotoProvider(apiService: mockApiService),
      child: const MaterialApp(
        home: PhotoGridScreen(),
      ),
    );
  }

  testWidgets('shows loading indicator when fetching photos', (tester) async {
    when(() => mockApiService.fetchPhotos()).thenAnswer(
      (_) async => Future.delayed(const Duration(milliseconds: 100), () => []),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow microtask to run and trigger loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('shows grid of photos when fetch is successful', (tester) async {
    final photos = [
      Photo(id: '0', author: 'Author 1', downloadUrl: 'url1'),
      Photo(id: '1', author: 'Author 2', downloadUrl: 'url2'),
    ];
    when(() => mockApiService.fetchPhotos()).thenAnswer((_) async => photos);

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Author 1'), findsOneWidget);
    expect(find.text('Author 2'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets('shows error message and retry button on failure', (tester) async {
    when(() => mockApiService.fetchPhotos()).thenAnswer((_) async => throw Exception('Failed to fetch'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // microtask
    await tester.pump(); // loadPhotos starts
    await tester.pump(); // loadPhotos finishes and error set
    await tester.pumpAndSettle();

    expect(find.text('Retry'), findsOneWidget);
  });
}
