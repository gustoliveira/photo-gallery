import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class PhotoService {
  static const String apiUrl = 'https://picsum.photos/v2/list';
  final http.Client client;

  PhotoService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Photo>> fetchPhotos() async {
    final response = await client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
