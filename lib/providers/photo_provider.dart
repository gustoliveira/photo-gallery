import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/photo.dart';
import '../services/api_service.dart';

class PhotoProvider with ChangeNotifier {
  final ApiService _apiService;
  List<Photo> _photos = [];
  bool _isLoading = false;
  String? _error;

  PhotoProvider({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPhotos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _photos = await _apiService.fetchPhotos();
      await _loadFavorites();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String id) async {
    final index = _photos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _photos[index].isFavorite = !_photos[index].isFavorite;
      await _saveFavorites();
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    for (var photo in _photos) {
      photo.isFavorite = favoriteIds.contains(photo.id);
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = _photos
        .where((p) => p.isFavorite)
        .map((p) => p.id)
        .toList();
    await prefs.setStringList('favorite_ids', favoriteIds);
  }
}
