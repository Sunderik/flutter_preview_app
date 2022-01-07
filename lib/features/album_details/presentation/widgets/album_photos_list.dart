import 'package:azorin_test/core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../album_details_view.dart';

class AlbumPhotosList extends StatelessWidget {
  final List<AlbumPhoto> photos;
  final StringCallback callback;

  const AlbumPhotosList({Key? key, required this.photos, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: photos.map((_photo) {
        return Builder(
          builder: (BuildContext context) {
            callback(_photo.title ?? '');
            return CachedNetworkImage(
              imageUrl: _photo.thumbnailUrl!,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image(image: imageProvider, fit: BoxFit.cover),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
