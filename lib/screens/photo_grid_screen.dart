import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/photo_provider.dart';
import '../widgets/photo_grid_item.dart';

class PhotoGridScreen extends StatefulWidget {
  const PhotoGridScreen({super.key});

  @override
  State<PhotoGridScreen> createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PhotoProvider>().loadPhotos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: \${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.loadPhotos(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: provider.photos.length,
            itemBuilder: (context, index) {
              return PhotoGridItem(photo: provider.photos[index]);
            },
          );
        },
      ),
    );
  }
}
