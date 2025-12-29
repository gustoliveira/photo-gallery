import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class ApiService {
  static const String _baseUrl = 'https://picsum.photos/v2/list';

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
