import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/photo.dart';
import '../providers/photo_provider.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;

  const PhotoGridItem({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            photo.downloadUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      photo.author,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      photo.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: photo.isFavorite ? Colors.red : Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      context.read<PhotoProvider>().toggleFavorite(photo.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
